Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD3481431
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Dec 2021 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhL2Op5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Dec 2021 09:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhL2Opz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Dec 2021 09:45:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE41C061574
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 06:45:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8B7614F0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 14:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA45C36AE9
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 14:45:53 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Fix cinfo on FS's that do not support IVERSION
Date:   Wed, 29 Dec 2021 09:45:52 -0500
Message-Id:  <164078891040.2414.11995954842150988952.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; h=from:subject:message-id; bh=hyxAWtKKiI6wKIURiVWPWSI0pC7tUg9oBkIpfiCdAF8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhzHSanlc4tYpnKnZq7DEcgsBKmrOjbvutg++vKGm+ 8NdQnQaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYcx0mgAKCRAzarMzb2Z/l8gdD/ wJPH8pGDLjtR3zbx7bZMNOTmAgW9JqRUEabehRFzF/g/SWUcwOud5qOUT9vrs7o9pA8I03U6/Mt1rM CvnVgeCrlf5NzLjCW3/WnJNNjVZM2BQLgKQ7iuAeuraqRdTb+dWwpbwRKJ+NvxiZ/GXO/ksW9JtuO2 3YMt1tpYYgbgHwNO2gDbF++GCWapFEYOhfJnhOxBvejZDcsEtppMnONOCOJP5B0YdTaiTt84SD5zmH KuPsfHJu6P7ugpExMYcfqshgYq6JxpGMbwocm4qksj+0BreCOTcUFpcu3U/4BQcgX11puuYkmgEFps amff6pFF8E52seNs4oSzlvv92nUCnNXdqxtkWka/c2lt5zUkVOgS5DHx9hbTr67MDQr9dAHZo5w36z N+BxiuYHJoTdL4dxsPYpfGSIZdT0fJU0YFK2Cu/ji03fZl00x+6BH87FI6x/3xKPvxAVPdK89ivK0B XVCD+oQPG2iojNhUF7OB55vTaYQA3EAmPu+AJu2tEaicpk8GQJVUeLAok2A4PoeEN1VG7JLTqGMw0o 0ZQvUwARrI/oJkvxqUHlFiz6qDVHjadyqFx4HauoaebiD2Y2rfNs+hhTBPElvu5oDnqxVSfzkcnvXx dIq6REm7PMxNXTvSBfbhnlgkcOLYmpd7EvnirvPUOaScrkOpCOOlgtzR1gXg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To address the problem reported here:

https://lore.kernel.org/linux-nfs/49640909-A7F0-4004-AF55-859621B26D38@oracle.com/T/#u

I'd like to revert 428a23d2bf0c ("nfsd: skip some unnecessary stats
in the v4 case"). The first patch in this series does that. The
second patch is related clean-up.

---

Chuck Lever (2):
      Revert "nfsd: skip some unnecessary stats in the v4 case"
      NFSD: Move fill_pre_wcc() and fill_post_wcc()


 fs/nfsd/nfs3xdr.c  | 65 ---------------------------------------------
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsfh.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsfh.h    | 40 ++++++++++++++++++----------
 fs/nfsd/vfs.c      |  8 +++---
 5 files changed, 96 insertions(+), 85 deletions(-)

--
Chuck Lever
