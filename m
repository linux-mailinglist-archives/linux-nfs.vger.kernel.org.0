Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0615B070
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLTFV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 14:05:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44094 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727279AbgBLTFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 14:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581534320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W/eQ3uj0GsQPg4RRr9RL70X+k5xo9D46GRy0E7hWr4w=;
        b=JghAvjeeQ4id/w5t8HJZRZq0hfqtIC/FcBzg0ObgdFS7HzRYtZChy+bEyuR4154WagM7gS
        Q2wqVm3LL/6kwvSZDWjlmP7ETDSLZW8joAfzTj0dX+SzD7TEBjhIQrHXrAVeogdOW9dImk
        cEDHRYxkg7OXZ90zSSLcTNJf1mDmwq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-q25vGg5sOj2u_uPeT3vzxg-1; Wed, 12 Feb 2020 14:05:18 -0500
X-MC-Unique: q25vGg5sOj2u_uPeT3vzxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C9308017CC
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2020 19:05:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA99860BF4
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2020 19:05:16 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] gssd: Closed a memory leak in find_keytab_entry()
Date:   Wed, 12 Feb 2020 14:05:15 -0500
Message-Id: <20200212190515.7443-1-steved@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When 'adhostoverride' is "not set", which
is most of the time, adhostoverride is not freed.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/krb5_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index a1c43d2..85f60ae 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -799,7 +799,7 @@ find_keytab_entry(krb5_context context, krb5_keytab k=
t,
 	int tried_all =3D 0, tried_default =3D 0, tried_upper =3D 0;
 	krb5_principal princ;
 	const char *notsetstr =3D "not set";
-	char *adhostoverride;
+	char *adhostoverride =3D NULL;
=20
=20
 	/* Get full target hostname */
@@ -827,7 +827,6 @@ find_keytab_entry(krb5_context context, krb5_keytab k=
t,
 				adhostoverride);
 	        /* No overflow: Windows cannot handle strings longer than 19 ch=
ars */
 	        strcpy(myhostad, adhostoverride);
-		free(adhostoverride);
 	} else {
 	        strcpy(myhostad, myhostname);
 	        for (i =3D 0; myhostad[i] !=3D 0; ++i) {
@@ -836,6 +835,8 @@ find_keytab_entry(krb5_context context, krb5_keytab k=
t,
 	        myhostad[i] =3D '$';
 	        myhostad[i+1] =3D 0;
 	}
+	if (adhostoverride)
+		krb5_free_string(context, adhostoverride);
=20
 	if (!srchost) {
 		retval =3D get_full_hostname(myhostname, myhostname, sizeof(myhostname=
));
--=20
2.24.1

