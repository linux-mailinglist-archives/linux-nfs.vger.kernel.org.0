Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5C2A1F19
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Nov 2020 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgKAPcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Nov 2020 10:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgKAPcm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Nov 2020 10:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604244761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=0Wj7ZfVzgf7VEzrGzNTq9aHl9BBDX910MMyPyWdtJRA=;
        b=QqbNYjTZ18qAYVa5T9zqUKHIzY8Rgtlf6PEEtnQWcmTlncZ93MIkPEp2IPnF5NR+6FQ78J
        KlQmJgSojyXIsvLPxaiLtnQ937VU+moAiym7twlotvP3GxcPnYj9jgcUSYGTHkPc3KcuMO
        E/GHWWE3NrY4bFi/Q58OKL5zVNv59LM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-UdfJ5GHlNwq95jnqEpTHnw-1; Sun, 01 Nov 2020 10:32:39 -0500
X-MC-Unique: UdfJ5GHlNwq95jnqEpTHnw-1
Received: by mail-ot1-f71.google.com with SMTP id b22so5182720otp.12
        for <linux-nfs@vger.kernel.org>; Sun, 01 Nov 2020 07:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Wj7ZfVzgf7VEzrGzNTq9aHl9BBDX910MMyPyWdtJRA=;
        b=VjbKj069SUnN5R8+NFCQScmYdLlTIOKx7edvQxOiuXCLj35dLBXgnN9F3mX19S5CNo
         A+HPD0uFqYJI7hgJPxD0G9rg0Rgw3hfZwwWCWmtDDSHnCKS4OxwPUITFyO/kZFU3tyHl
         2Z62fo/cWm/7iGi5ZmydCUx8r6F1Ckas680BbyfPSpURAKknYk2llqs9TXpDLFDaV8ME
         T5DmUGJWWDDGF3ayXUiVqWJpcgrqMt2L0S4vUhh6TTiFsHFBSCSn8vyG3kqKXcTfPbLw
         IL7Xbkih6/2KxXlXFNiY+TeiGNDODiN6fkjPTy6dogPknPgXl1auZqEGmRrv//B7qBCV
         B+lQ==
X-Gm-Message-State: AOAM533i6xXBEcOEGU+AtWBWEV06B+9kResCnueta8orTQQ/6OhuIGOM
        Z9hPfEy8xD7eWWiz9DxT5jQKz10StnZ4B/98Vj9hq8SLEbUH+gx4eYS/ShpdKXXgfboZI2HorVS
        Vr01rAjEmBnKKJAN83f7u
X-Received: by 2002:aca:ddc6:: with SMTP id u189mr7588020oig.59.1604244758892;
        Sun, 01 Nov 2020 07:32:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+yaDR+vmXW5TAdApQPiTp1L9iVD3d3dVF5lgdSEQY1at+uccJHMDpFE73E8hFXGFGVz0ZHw==
X-Received: by 2002:aca:ddc6:: with SMTP id u189mr7588015oig.59.1604244758770;
        Sun, 01 Nov 2020 07:32:38 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x25sm2943778oie.17.2020.11.01.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:32:38 -0800 (PST)
From:   trix@redhat.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfsd: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:32:34 -0800
Message-Id: <20201101153234.2291612-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f4..6020f0ff6795 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2558,7 +2558,7 @@ static u32 nfs4_file_type(umode_t mode)
 	case S_IFREG:	return NF4REG;
 	case S_IFSOCK:	return NF4SOCK;
 	default:	return NF4BAD;
-	};
+	}
 }
 
 static inline __be32
-- 
2.18.1

