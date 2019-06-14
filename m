Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F367A4687A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfFNUA2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43736 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfFNUA1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:27 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so8322377ios.10
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5T8FnwhN82IufgsRsLgZhkGBNLWRK3HNau7IrIjywU=;
        b=EUVjk4ecgb0GwT4c0ksSd2Mk+xgUWnLonWk+SiLHZ44s+R9c67UwjJgdVDk1zkdaMT
         bmm/eqxhrO5Qjj951DQ13ibCQs+HoGCM6i2dF3q+Ho6K4ea3OJGXz9NwyJJm0S6OTaxJ
         3RG98wlnxS9jSLS7AmrMKaOXRWEeF3vFhAGGCBN1pD+F+CJr3M1rJR3qt4JqSmaay2b/
         jHCxPafHJkirD2f7if89njzjd3gpN1qwL2qs5aelInRj9I4D9fDzyW76sTM6w39h+Y+X
         BtoJxvyMDTyftJkz06hzsKU3dxgN1bdeVz0pYciHVu93ERurnMQr5y42HiNsqkZN01Xo
         6lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5T8FnwhN82IufgsRsLgZhkGBNLWRK3HNau7IrIjywU=;
        b=WnA7HNw2PXBPpFc1CrE5kAxCsewkiadI0zHQAkT0tUZ9yTRmVbkqW71ZVOvLu6gVPN
         BitaOYwi904VvCzsjyRlaQSTxR0rZyvOccSnX1WA4GO/n0TY4GCvpASGNGhTWoj71ndu
         68Olp5SZawmYMvZjSex9MwIANMknGH/S+gOyLVoPYQVongOhbQOi0lCnNS3w4IqTqQKa
         941ylrAzKamGtP3FefdJ6NQckV2rPXUjJxMt/MWCkjImYmTOXAJ5mEgYxtRJofSpwm1g
         eDM+azPzZc9RRBjQCO9s0OfRST51rzUJdSJrQEwg7iNtLPdtWa0mq9Gg51uA7jI6KytH
         pxRw==
X-Gm-Message-State: APjAAAWZ0qTFCr5TWGOgc+aFs7VIljDN94P3ANeGKzmRuXKjoolNYtGG
        9wuzUM+4yPkh7Sqoal5YSB8=
X-Google-Smtp-Source: APXvYqzazqWTo+/UWZ1nX1vxqhR7KMjyVL/n15pGV4DofZsF7QvTCB5u8/77OnKYGCnv9Qzd8nCXsw==
X-Received: by 2002:a5e:aa15:: with SMTP id s21mr3281391ioe.221.1560542426985;
        Fri, 14 Jun 2019 13:00:26 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 09/11] NFS handle NFS4ERR_PARTNER_NO_AUTH error
Date:   Fri, 14 Jun 2019 16:00:14 -0400
Message-Id: <20190614200016.12348-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
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
index 90ab08b..895e7ef 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -458,6 +458,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_ADMIN_REVOKED:
 		case -NFS4ERR_EXPIRED:
 		case -NFS4ERR_BAD_STATEID:
+		case -NFS4ERR_PARTNER_NO_AUTH:
 			if (inode != NULL && stateid != NULL) {
 				nfs_inode_find_state_and_recover(inode,
 						stateid);
-- 
1.8.3.1

