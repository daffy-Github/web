import SwiftUI

struct ChecklistSectionHeader: View {
    let title: String
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text(progress, format: .percent.precision(.fractionLength(0)))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            ProgressView(value: progress)
                .progressViewStyle(.linear)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ChecklistSectionHeader(title: "Preparation", progress: 0.65)
        .padding()
}
