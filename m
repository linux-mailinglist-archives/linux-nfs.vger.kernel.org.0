Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D522112B2
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgGAS2O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:14 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:44331 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732913AbgGAS2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:12 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0007YE-9i
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gYX+7RNBaTbZZOZJzL8K2PpyO2kzTUcgb92OUP7klbw=; b=eZhEnwwAHnpjBP8cNtuyYXuRTQ
        s8ZAkN/YXvSehvf211hwYxwUpen4bf1nNeF3LIzzyX2HHWYMiyTPg1qxNzjTQxONWGaDphwcNGrRE
        nV8whuz4XnS5yR8MJPRKMHacyThRt3AiuBqUqy3tHkUyty1jeOsdrB96slpw8MHrWyO0NCDfTJh0f
        HJYos1X0Cv3KKUM4fc3JKpqGlWszj9ZqxajXzYR4yA/4YdFLVQwpD+rcfUQc13VEKdV3KQg/PoA1+
        TE6QRdyVdU2G2zQt4N0JZez548pXAJVmZ+3B/2ro3b5VUdESHLYXUdV4i5FzWM7qESYVIxbSBvxfB
        66mS0j0A==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0003Oc-3I
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:09 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/10] gssd: Add a few debug statements to help track client_info lifetimes.
Date:   Wed,  1 Jul 2020 14:27:57 -0400
Message-Id: <20200701182803.14947-7-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701182803.14947-1-nazard@nazar.ca>
References: <20200701182803.14947-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00827923689103)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVUHsrAzWQp/yE
 PBOCrU76l0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIYIZ0EfxE+kAsZjuLxUDwfgp96GRUoRrhlXM755zELsnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhUS7X/HdQ0FrywPXk+OzbcX9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVM7CC2z6Dgs2SNe1BxOjU9h4mmDw+jSOvRXT0+kK2yg5ZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/gssd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 54d9b5de..7ad38b6f 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -520,6 +520,8 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
 		if (!strcmp(clp->name, name))
 			return clp;
 
+	printerr(3, "creating client %s/%s\n", tdi->name, name);
+
 	clp = calloc(1, sizeof(struct clnt_info));
 	if (!clp) {
 		printerr(0, "ERROR: can't malloc clnt_info: %s\n",
@@ -561,6 +563,8 @@ gssd_scan_clnt(struct clnt_info *clp)
 	bool gssd_was_closed;
 	bool krb5_was_closed;
 
+	printerr(3, "scanning client %s\n", clp->relpath);
+
 	gssd_was_closed = clp->gssd_fd < 0 ? true : false;
 	krb5_was_closed = clp->krb5_fd < 0 ? true : false;
 
-- 
2.26.2

