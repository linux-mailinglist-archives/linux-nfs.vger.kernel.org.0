Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B210D29DC
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfJJMqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41008 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfJJMqg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:36 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so13271827ioj.8
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gDbR4PUkDOJDj5ky2g1fhHAP2/+scIqy7aML0qKzZWk=;
        b=diobS+m1pjDhM9seM908LAuvvhlYJbU3dkS+/aKC0sHYQepK9nH43Qb3GI7rIPdUzh
         77ExAK7VnzbM+OHTQyT9Le9Ahc+k+funYpLn0KQq1AhSNvUPt0B9n4s1mWt5anLfFy3L
         h7Fn+pWMHTiJDyLHQ3pVr5m6/n54X1bwANw2241WUcuEXGjHfp+LzfHEGdZIWtYd+dxH
         ZecwR5F4qscV40OxovVIMk5s3m5m2FLnysnZHesvkzgqG3phDDZLl1b0gn9zNMOXzb5o
         f7b4IJ4FTRebNAZAHoW3+et2s8ZAid64tJPS8OM9q7lWBvjRRLBO8V7pVEBVlWj1u2dQ
         3O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gDbR4PUkDOJDj5ky2g1fhHAP2/+scIqy7aML0qKzZWk=;
        b=OHQfnN1QkplXDR4EPqnjcHNZlTju1SaVamjI6f3a2XuFtUfow8ss8hzC2J1a5n+WyS
         fTb8ahg3VDVolNuV6epUCmYsc51vvgGNvsM5evnBDKaZOwKbx52cPdF9X4k8AqoFMzhI
         CPwrRZ+xoC3KXnhNUfiQ6QNGhLkUprQWD46obFLA7cqRnLvY9n4GFXB2s2MASnS8NDIr
         KD+tCKjKk9tsgUiigHAlcx77+UbVhoO8nKBHa5vSR/CqhXvX1oqgFZFvaqsFMkTpCJ2v
         iHr5fxXTOSPUvAG8BxLFHCJNWvoNvYlj9Iv48sNFFeRlay7vgHBgQSxp5PyPgYdEAOfu
         kE2w==
X-Gm-Message-State: APjAAAWIABqYw7Z/0NVe695xWW4D0fOzlMvUkYvuAv8oRZ1khCHNkbvj
        skFVCKYqslkZRKznz+FAokA=
X-Google-Smtp-Source: APXvYqxXgSrKvAI656cU8m+FafZXZAx63etBD7ryT3Nyedi2oyJMON4RsP8SDMiWrDIuEIHQqfBPIQ==
X-Received: by 2002:a02:661d:: with SMTP id k29mr10192092jac.35.1570711595622;
        Thu, 10 Oct 2019 05:46:35 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:35 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 09/20] NFS handle NFS4ERR_PARTNER_NO_AUTH error
Date:   Thu, 10 Oct 2019 08:46:11 -0400
Message-Id: <20191010124622.27812-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When a destination server sends a READ to the source server it can
get a NFS4ERR_PARTNER_NO_AUTH, which means a copy needs to be
restarted.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f3a1f8d..a7a55d6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -475,6 +475,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_ADMIN_REVOKED:
 		case -NFS4ERR_EXPIRED:
 		case -NFS4ERR_BAD_STATEID:
+		case -NFS4ERR_PARTNER_NO_AUTH:
 			if (inode != NULL && stateid != NULL) {
 				nfs_inode_find_state_and_recover(inode,
 						stateid);
-- 
1.8.3.1

