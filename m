Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D7425D13
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhJGUTP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 16:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233974AbhJGUTO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Oct 2021 16:19:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF77160EE0;
        Thu,  7 Oct 2021 20:17:18 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Clean up svc scheduler
Date:   Thu,  7 Oct 2021 16:17:17 -0400
Message-Id:  <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=490; h=from:subject:message-id; bh=Z0ToIjfziJX112Iodnrc0Oc8pcpmickKGvq8WHrDwZE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhX1XN+DRDev4s1/aA3fqZRSEKO7xPkUQqBqaX9sHk FNwyR+OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYV9VzQAKCRAzarMzb2Z/l5W9D/ 9NFP2gM2BrGGzsbWVFDAqdwJcQa/AmNT7+8vVX29z2NtsmhY/ZuDpfNMdlm5bixXkQq8pueVsfgOW3 FOSC+XMD6GyxumfGFmuSIQ8KIe1JlegzHmlqdyH2AE70E3bHXbrTSfJ8VvqIKsG4I39FVQrDZoXMAw OdbT/NsNjJignoExqwHOOQtV46qFNgvd0jJwlQ8okgPptKzMkdXJgUiAAmnSvHhLTGkzMX2U+d76PY Oug+jTip3LJf6et4J0EZAcMMdKjDWGlMQvB4E41/aQYdxVkTVc4heHNo4us88f5Lquat5fDgebZX9E Bpecuxexx8ME0WtNPPRJ59ar5RT1apoCt8Dv9BMOx2vLUTMGRAh27APtywEAY0XXEIHULZZYnr3nrG YI5AgLNdCGbFxW5LgwdjRQk9KIBnLJGlH5U8xrnzZocME806Oc6WiNekWRrmBzTt16KXh7piopdqJ2 FI/JHq4qjfFlLrr37KLuCV159Aq/J8vbxOOJJDhZbBqMhWgfm8gkO9P7T0bwg8Er4h7IhlRE8ea+oR /asv3ZLfdTVx6o9cgXzPah9cy03lryUYgZ7reRUZVXKs1Zm+2BJB8cTf3uxTfwQAqi0Bpr+x6xhoom NA84i5IOzPNxofS79L0JjgYl7sertLQhO8gEIT8UaKSxbyfyxpMfrkfUH7NA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce. I forgot that these two go together. Sorry about that.

"SUNRPC: Simplify the SVC dispatch code path" is unchanged from
its initial posting a few minutes ago.

---

Chuck Lever (2):
      SUNRPC: Simplify the SVC dispatch code path
      SUNRPC: De-duplicate .pc_release() call sites


 include/linux/sunrpc/svc.h |  5 +--
 net/sunrpc/svc.c           | 69 ++++----------------------------------
 2 files changed, 8 insertions(+), 66 deletions(-)

--
Chuck Lever
