Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF367229025
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGVFyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:54:02 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:45393 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728234AbgGVFyB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:54:01 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-0005jX-L5
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 00:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DWchFTFnOgAHm4GZuMrwPrC6n0fwN8W5sBIdzA0NVT8=; b=F0VoPxiv6nuWNt0l7G8n+K9Ayg
        yxdrmI3yq73W6ywztF8DF5FAuk60Lk/kpZlurShVLEgvCiXHiyECY1p0l97WnI5a3Yno7/68SmFh4
        TNox9Hgqb8MAEfkdiTFGsWDFrBEo3x8zLLO5Bkx9z7pajI7hyRnba4aJwsXpV4LYrrJz5bwDxJ9qN
        YJnzYYGGaEv8LGKC51YoTjKeYJJB7NuEfrlhLMaNDR9mf4Ec7Njt5+UWCY5f/dXB9mEbTHMPHlYol
        IxYBjIe7vQkA/hQFKBFF4SxpSFIPo4Kx5xSXobUGzIHkMsVbjy9GmgYRO07twgHsryaUlYMxlDg9D
        SOq9+MkA==;
Received: from [174.119.114.224] (port=44746 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-00076P-Ee
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 01:53:59 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] nfsidmap: Allow overriding location of method libraries
Date:   Wed, 22 Jul 2020 01:53:54 -0400
Message-Id: <20200722055354.28132-5-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722055354.28132-1-nazard@nazar.ca>
References: <20200722055354.28132-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVvOebW5YVt0OW
 3PsxRCxorETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dL+t0ckeTZS4MBf9PRWTkhL8XMDNGgxMYuTJb3gku0denXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSOk
 kh42R2/YqM4PxCyG6Zsg9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5hflRE
 ntAvetelzJShaAOIpRNsRA6V3icTKXHYhsutbMr5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 support/nfsidmap/libnfsidmap.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index 6b5647d2..22b319b8 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -237,24 +237,40 @@ static int load_translation_plugin(char *method, struct mapping_plugin *plgn)
 {
 	void *dl = NULL;
 	struct trans_func *trans = NULL;
-	libnfsidmap_plugin_init_t init_func;
+	libnfsidmap_plugin_init_t init_func = NULL;
 	char plgname[128];
 	int ret = 0;
 
-	snprintf(plgname, sizeof(plgname), "%s/%s.so", PATH_PLUGINS, method);
+	/* Look for library using search path first to allow overriding */
+	snprintf(plgname, sizeof(plgname), "%s.so", method);
 
 	dl = dlopen(plgname, RTLD_NOW | RTLD_LOCAL);
-	if (dl == NULL) {
-		IDMAP_LOG(1, ("libnfsidmap: Unable to load plugin: %s",
-			  dlerror()));
-		return -1;
+	if (dl != NULL) {
+		/* Is it really one of our libraries */
+		init_func = (libnfsidmap_plugin_init_t) dlsym(dl, PLUGIN_INIT_FUNC);
+		if (init_func == NULL) {
+			dlclose(dl);
+			dl = NULL;
+		}
 	}
-	init_func = (libnfsidmap_plugin_init_t) dlsym(dl, PLUGIN_INIT_FUNC);
-	if (init_func == NULL) {
-		IDMAP_LOG(1, ("libnfsidmap: Unable to get init function: %s",
-			  dlerror()));
-		dlclose(dl);
-		return -1;
+
+	if (dl == NULL) {
+		/* Fallback to hard-coded path */
+		snprintf(plgname, sizeof(plgname), "%s/%s.so", PATH_PLUGINS, method);
+
+		dl = dlopen(plgname, RTLD_NOW | RTLD_LOCAL);
+		if (dl == NULL) {
+			IDMAP_LOG(1, ("libnfsidmap: Unable to load plugin: %s",
+				  dlerror()));
+			return -1;
+		}
+		init_func = (libnfsidmap_plugin_init_t) dlsym(dl, PLUGIN_INIT_FUNC);
+		if (init_func == NULL) {
+			IDMAP_LOG(1, ("libnfsidmap: Unable to get init function: %s",
+				  dlerror()));
+			dlclose(dl);
+			return -1;
+		}
 	}
 	trans = init_func();
 	if (trans == NULL) {
-- 
2.26.2

