Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D112662950
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391660AbfGHTYt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43331 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391658AbfGHTYt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:49 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so37809755ios.10
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NMgsPwcgWqY799nLZlYuCre0/XwCSngAA3yPJe7nzXA=;
        b=pZa+FrrhJrg7gebnCnTwMs8MW/J/u+rhUjmZjQ5sJ7mNRxCOjetNm8qaxwBkqsQoBc
         ZacHDmZkX2qxT3JKk1DU/uU9a0JHh+nBIUv4wy3udt0QvOLyBOFKtK9DJ19yCtAC7Ld4
         wbielMxGqYc5Zxj+aGaGzZN6bcqUAYg1IaQDpxzTOInjkBCItP77CJlbU4er4VKNsBeo
         RJVVXBYycO4T87r9EnJqIqJtN67EzK4USYzUo+1TZEVUroxlFoKccqh9l5TmmOu/EgL7
         T+BQ4eqY5THDoNud/7Ada8/qAEd2YQxaltW4E56cL2F7d/sIOr1o1LhL1EICkjTRm/ck
         IOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NMgsPwcgWqY799nLZlYuCre0/XwCSngAA3yPJe7nzXA=;
        b=YZgrhU0A+96nPi6oqDujwd6cN6HlkBhTZ8gkxVDWtDpybwdD6xs3GPQlWsyBkc2/TF
         e/bg4JmEU/GgMrP/QbAUuFhpGFUJ1FTs17G/W8itsWeesAHgpR4Sf37ynTx21sawo6qZ
         XUqDWsFXbvLz3o6weCrhLtg9b3j2HOj8tlyq7w8WmQB95VuCBGZ92pj9/7vMitvBAvWm
         Jg7wrzgD0u0ZNCY+VAn3F9ap0AerDsAl4bGrwGXdWWe1YkBDFCWz6ql9Csd3ymUaFe80
         Sw/s/IdBkeUifrO0ggqtmU3pZeBtb6lyUyc89tuqzTns3lLTTQAnND78n4Otr+v55HLT
         c4YQ==
X-Gm-Message-State: APjAAAWMDau/A6LpWB8XiotSnytH8NXQmzSw3cITnQ3y15HNpaU9lcNE
        AefHJrSQVI6CG874r65BOPE=
X-Google-Smtp-Source: APXvYqzKXvAeECRGfNGRrz/xQf5zEC69ybhPt0Spi4Ih4YKaHMDLHZMwf6n+SvSPHlj9eFIMaN2o+w==
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr19862457ioo.95.1562613888216;
        Mon, 08 Jul 2019 12:24:48 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:47 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 06/12] NFS: for "inter" copy treat ESTALE as ENOTSUPP
Date:   Mon,  8 Jul 2019 15:24:38 -0400
Message-Id: <20190708192444.12664-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the client sends an "inter" copy to the destination server but
it only supports "intra" copy, it can return ESTALE (since it
doesn't know anything about the file handle from the other server
and does not recognize the special case of "inter" copy). Translate
this error as ENOTSUPP and also send OFFLOAD_CANCEL to the source
server so that it can clean up state.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e34ade844737..6ed5a16dc511 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -391,6 +391,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			args.sync = true;
 			dst_exception.retry = 1;
 			continue;
+		} else if (err == -ESTALE &&
+				!nfs42_files_from_same_server(src, dst)) {
+			nfs42_do_offload_cancel_async(src, &args.src_stateid);
+			err = -EOPNOTSUPP;
+			break;
 		}
 
 		err2 = nfs4_handle_exception(server, err, &src_exception);
-- 
2.18.1

