Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E4228FC5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgGVFe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:34:59 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:46865 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbgGVFe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:34:57 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P3-0005QU-Vm; Wed, 22 Jul 2020 00:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3JwW1YuO9Q/OWrfQqDosBSZXpmogy39bOokNq7hmivY=; b=ia9MO8lZ+hVtWludoXbRRsmGbv
        MXdoL1kSmMtPT5pBLy0S+Z15wX1MaT5uUEPSoSuxffWkIMVt3+tjgEhNT/1AyunBslLxGrPmTNaoJ
        XPoUzK2zW3I9o8yvFOi03u35K1FHbWYkhr3r9S5vITYqwZ4H6n1JtzuVP1Ao0gfyG6lplKEHtyjL/
        JtY8GbOSnY4OAjO7mopM9je/T6AJi4DXGhbk/ub8THj9H438efcVM+dMd+d2ajpLsNzeSpUubcV5k
        2BjpVGTN7gkWCU2uEhTQll8Xn2ahpdIeFvi2CTaaLJ9MGt+WEqFj2A/u4qtfKpaTAObK2kIzj76oF
        lJJ5Kx3A==;
Received: from [174.119.114.224] (port=44150 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P3-00045O-N3; Wed, 22 Jul 2020 01:34:53 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] svc_dg: Free xp_netid during destroy
Date:   Wed, 22 Jul 2020 01:34:41 -0400
Message-Id: <20200722053445.27987-2-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVnvd16l5gXDu1
 vlgDJhx7DETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KnRr9dv6aS/XsdM3hwL/Vxz9G
 0IA9bRwRct9JixjrSnwE9+MNv0Z9Z/ftUlQdQf4t0vBWG099Hxh0Nb9o6T55Sb4hKsV7vZ7I7qfm
 2H1RjeqnoiZrOhGsXaeAnPVKet4Y1/BgStvhQrzEV/3sSgXiDA8Wchfv6rsJV69dwwRye5Fqf5gk
 ygI/REKLXOuXEMRCFDpXnW7vq/flvXA178y90oxHpGdcOo7PShBgpIzYxnXDldmsGq7kDyH0ew4I
 Dw+CACkJUHU38G0nImq/tiQjLLdHRLp5rVU0FqkdDCRmJ2BgSGUuK0YJtRg9EDez7Ku5DKDi4xrE
 c/zFBOmiGaAnFDV0eGlRuLVR1NWZXcsvs30x4KEUiJDRsmQ5HT3VKkMngMDkh+x5vuoVP4y7XWE4
 hh0K7aaWJsTJLX1F+5HwflHXs2KsRjKrCowEavDwQuKoFXnYnNNCNwgP2MQ1gciXBQ+q69NBV6o+
 QUIkaY4elbUUfTr26s/5PSZcfEU2ZCQrKTjECb0PwpN4olPuA0AI9+ulfm1tbbH4NsTwNgi2MDfQ
 SgMHurv2dxDwgdigsjtQ+68vj/Zr5D+lbOOtFT7Wk7yyri//9sNP2pYqoDB9thlY1X8TIU8K2we6
 6+hZ1BoFExuGjqPWk46FoQRGMpCW/+R/y847K936Ks6Fu8uhrJCPPZiKGTzb2X0CsNjV/ErluLyc
 9vuJG2bK/+wZJ/tpqBD2vvTWdasCwvCiFabvBgsCDk9os2Xse5/Y5KszrdTTrbe66eBlmvgK/9Sz
 Zj1hFBxwEiTVJqDh0qKoKsXx5llbf0i+3nLTOhKYZNMsjrDtoZv1Jq9xAcIT3xed7wGmqxx1XE8q
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
 src/svc_dg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/svc_dg.c b/src/svc_dg.c
index 894ee9b..a9f63ff 100644
--- a/src/svc_dg.c
+++ b/src/svc_dg.c
@@ -328,6 +328,8 @@ svc_dg_destroy(xprt)
 		(void) mem_free(xprt->xp_ltaddr.buf, xprt->xp_ltaddr.maxlen);
 	if (xprt->xp_tp)
 		(void) free(xprt->xp_tp);
+	if (xprt->xp_netid)
+		(void) free(xprt->xp_netid);
 	(void) mem_free(xprt, sizeof (SVCXPRT));
 }
 
-- 
2.26.2

