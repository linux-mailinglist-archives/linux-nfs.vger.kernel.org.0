Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44057155A90
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgBGPVX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 10:21:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57640 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbgBGPVX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Feb 2020 10:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581088882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fsyrVk0mGd0ZEVHp2hneeW7+i+bHL9XfkOsbe4TCHmg=;
        b=JZzKCqplr57MYoBDOcQ81ntz2yvGEPlT9KXWwgtp7Z/M5v+cC+rZyxh8oc8+0DUIyZcT5F
        PXL7Yh14VS44twf8EYF/GYW4KAE1oGGskiw8Iw+/9MkhYlLAbqh3sIlnpkXKzw3qbaqPv5
        hgdwzBN2tGPy2DkxA3PkbC0tKp2C0PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-p4vAf-zvPD67R_tgxc4ngg-1; Fri, 07 Feb 2020 10:21:13 -0500
X-MC-Unique: p4vAf-zvPD67R_tgxc4ngg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A0D184AEA3
        for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2020 15:21:12 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92FF7790D7
        for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2020 15:21:12 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] query_krb5_ccache: Removed dead code that was flagged by a covscan
Date:   Fri,  7 Feb 2020 10:21:09 -0500
Message-Id: <20200207152109.20855-1-steved@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/krb5_util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index bff759f..a1c43d2 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1066,8 +1066,6 @@ query_krb5_ccache(const char* cred_cache, char **re=
t_princname,
 			    *ret_realm =3D strdup(str+1);
 		    }
 		    k5_free_unparsed_name(context, princstring);
-		} else {
-			found =3D 0;
 		}
 	}
 	krb5_free_principal(context, principal);
--=20
2.24.1

