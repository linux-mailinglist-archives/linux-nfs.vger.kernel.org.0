Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6241961DA
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgC0X1b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:31 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:51393 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgC0X1b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351651; x=1616887651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wNkAfSTgdEAIbGcVb6r+bcMQaXx7rIi2krMlk1sNQPM=;
  b=H7ZO//jFyG8jyTD2UicWo1kyqKtVahmAlfXvbxOtfU6GukVhx67vKsBO
   DqLlXiAGZ1mtJFWKopwpnCSXoskvhc9Kvdk34RskG1TtjWn+6qLsOwBZM
   tRYnyINsxyZPFpPs+5oxW7irFJJ6PWPwXVqSeGpgwptcIl4cV1YkPk5uW
   s=;
IronPort-SDR: A/fs2mQvYBKtoN5l+EQETFXtItOyIibhLue6RpCt1boxGJMfFA29L/bDosRmDqqSrIJtpZEH5e
 iEaauPPl8H8w==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="23086497"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Mar 2020 23:27:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 2EA21A2A33;
        Fri, 27 Mar 2020 23:27:18 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:17 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:17 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 54658DEFB8; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 11/11] nfsd: add fattr support for user extended attributes
Date:   Fri, 27 Mar 2020 23:27:17 +0000
Message-ID: <20200327232717.15331-12-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Check if user extended attributes are supported for an inode,
and return the answer when being queried for file attributes.

An exported filesystem can now signal its RFC8276 user extended
attributes capability.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4c4508f1bb8e..5acf719c0451 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3229,6 +3229,15 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #endif
 
+	if (bmval2 & FATTR4_WORD2_XATTR_SUPPORT) {
+		p = xdr_reserve_space(xdr, 4);
+		if (!p)
+			goto out_resource;
+		err = xattr_supported_namespace(d_inode(dentry),
+						XATTR_USER_PREFIX);
+		*p++ = cpu_to_be32(err == 0);
+	}
+
 	attrlen = htonl(xdr->buf->len - attrlen_offset - 4);
 	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, 4);
 	status = nfs_ok;
-- 
2.17.2

