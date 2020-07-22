Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB4228FC8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGVFfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:35:00 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:53395 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728050AbgGVFe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:34:57 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-0005RZ-UB; Wed, 22 Jul 2020 00:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GhBE8z9YEpQpBLugZHjTNmCRm5AbosxwfEPwawYT+Hk=; b=PuwkofVo7VjKQLRf28aZofFhWu
        sv7mUKlkjwpKapyPeQs0UmIoB5xTw+4FgJUIb29h3qldzZBNk9qPH0qntivPrtg6zkmIJHoXTuPRL
        0QyyG0yq1kZs9l2ePPimS0/oNrZtRi32tItyMaiz5EnzzRfgrZwDeoLN6gwEKbkS0+U/W1BNj0bV9
        JMTsjd/JWgbE3l+4R8KxvJTGkO1trRkuXALWrjYUPZIcHLV7E+iY4oM95BPwEfDrnFIj2Bbevr7T3
        yw05iqh65Z0OZgPWBfCkn96aPuEwqofu6DFJ7ONr7TDX2kvdAY+6uWHdeWb0Rl9djxan9lQZg5KU2
        YyCuK5XQ==;
Received: from [174.119.114.224] (port=44150 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-00045O-Ij; Wed, 22 Jul 2020 01:34:54 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] Use static object on main thread, instead of thread specific data.
Date:   Wed, 22 Jul 2020 01:34:45 -0400
Message-Id: <20200722053445.27987-6-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722053445.27987-1-nazard@nazar.ca>
References: <20200722053445.27987-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVHSGvxC+6WArI
 YknVwOXIi0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KnRr9dv6aS/XsdM3hwL/Vxz9G
 0IA9bRwRct9JixjrSnwE9+MNv0Z9Z/ftUlQdQf4t0vBWG099Hxh0Nb9o6T55Sb4hKsV7vZ7I7qfm
 2H1RjeoUWATv33b4UNCovA+yHUPa1/BgStvhQrzEV/3sSgXiDA8Wchfv6rsJV69dwwRye5Fqf5gk
 ygI/REKLXOuXEMRCFDpXnW7vq/flvXA178y90oxHpGdcOo7PShBgpIzYxnXDldmsGq7kDyH0ew4I
 Dw+CACkJUHU38G0nImq/tiQjLLdHRLp5rVU0FqkdDCRmJ2BgSGUuK0YJtRg9EDez7Ku5DKDi4xrE
 c/zFBOmiGaAnFDV0eGlRuLVR1NWZXcsvs30x4KEUiJDRsmQ5HT3VKkMngMDkh+x5vuoVP4y7XWE4
 hh0K7aaWJsTJLX1F+5HwflHXs2KsRjKrCowEavDwQuKoFXnYnNNCNwgP2MQ1gciXBQ+q69NBV6o+
 QUIkaY4elbUUfTr26s/5PSZcfEU2ZCQrKTjECb0PwpN4olPuA0AI9+ulfm1tbbH4NsTwNgi2MDfQ
 SgMHurv2dxDwgdigsjtQ+68vj/Zr5D+lbOOtFT7WkzWoZJcRHpHRblcrQmJi4OdQRKuacpvqmnou
 P2kU4W/wExuGjqPWk46FoQRGMpCW/+R/y847K936Ks6Fu8uhrJCPPZiKGTzb2X0CsNjV/ErluLyc
 9vuJG2bK/+wZJ/tpqBD2vvTWdasCwvCiFabvBgsCDk9os2Xse5/Y5KszrdTTlqigJEl1AperRC8L
 QIab+hxwEiTVJqDh0qKoKsXx5llbf0i+3nLTOhKYZNMsjrDtoZv1Jq9xAcIT3xed7wGmqxx1XE8q
 iL+B/6VrQyOXCK5m866CV4x+8EDWP5Dt8orPKygtVd32N1s3THnwUUyY+7Kh11Xmv+TszuJqCiWT
 xnCBYfMJKY6wXFFS639jBMHAePQ44lqMDpyryPGheI8wLmjmUhnjY+kgx3rv6P0wL+KoM0pOgvbF
 CaqvXm81A7xJ
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 src/getnetconfig.c | 3 +++
 src/mt_misc.c      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/src/getnetconfig.c b/src/getnetconfig.c
index cfd33c2..3a27367 100644
--- a/src/getnetconfig.c
+++ b/src/getnetconfig.c
@@ -136,6 +136,9 @@ __nc_error()
 	 * (including non-threaded programs), or if an allocation
 	 * fails.
 	 */
+	if (thr_main())
+		return (&nc_error);
+
 	if (nc_key == KEY_INITIALIZER) {
 		error = 0;
 		mutex_lock(&nc_lock);
diff --git a/src/mt_misc.c b/src/mt_misc.c
index 020b55d..79deaa3 100644
--- a/src/mt_misc.c
+++ b/src/mt_misc.c
@@ -112,6 +112,9 @@ __rpc_createerr()
 {
 	struct rpc_createerr *rce_addr;
 
+	if (thr_main())
+		return (&rpc_createerr);
+
 	mutex_lock(&tsd_lock);
 	if (rce_key == KEY_INITIALIZER)
 		thr_keycreate(&rce_key, free);
-- 
2.26.2

