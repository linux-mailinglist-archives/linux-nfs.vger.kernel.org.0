Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9D2112AF
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgGAS2M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:12 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:56179 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732851AbgGAS2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:12 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0007Xa-Sw
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t5cDzxl6sKugrK/7FpMT07UzH0i4tHTqLqYa785NdMw=; b=ewkOjWRhaWP4xND4b1NCoBx60I
        uECwFtesrC5zRLY+ZfNfXIlWH7HPgfOYTVhgFo9L7q279Pp5TM16g+JtyLJelDLwf+ho5TjVwRSHq
        vhxTRSEwbHOStrDJeDkoPyL5Xec01rJxXWmj4Gfv9GSoAjROSyPEp1DgNrzsKni00uMjbK6v4eVks
        eDsJkMzRddccDGSPrnDAjz/7kBr/DA0PKRbI5Bx17PGSw02T324A24rorqm38wuR4RnvdxV7kks31
        4GaqvDVhvqKJJaba7QNI8QpDIWEeQc/BvPi4X75T6fxaHjK47zOhv8Tw9xj3qVKWvi1PoAS4dHRmB
        iBe6EwJA==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0003Oc-Ly
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:08 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/10] gssd: gssd_k5_err_msg() returns a strdup'd msg. Use free() to release.
Date:   Wed,  1 Jul 2020 14:27:55 -0400
Message-Id: <20200701182803.14947-5-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVZg6CahN//B4f
 LTeyMpIj4UTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIdaSOwacg3+IB6z0o6nHs48XMDNGgxMYuTJb3gku0denXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSN0
 E4yABSDTp6KO9NSnhOBJ9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5hXzyQ
 q6QWI/yJc3PvhSRRhleyRbrzGQQUEIOPm9iQDjr5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
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
 utils/gssd/krb5_util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index c49c6672..b1e48241 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -484,7 +484,7 @@ gssd_get_single_krb5_cred(krb5_context context,
 	if (ccache)
 		krb5_cc_close(context, ccache);
 	krb5_free_cred_contents(context, &my_creds);
-	krb5_free_string(context, k5err);
+	free(k5err);
 	return (code);
 }
 
@@ -723,7 +723,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
 				 "we failed to unparse principal name: %s\n",
 				 k5err);
 			k5_free_kt_entry(context, kte);
-			krb5_free_string(context, k5err);
+			free(k5err);
 			k5err = NULL;
 			continue;
 		}
@@ -770,7 +770,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
 	if (retval < 0)
 		retval = 0;
   out:
-	krb5_free_string(context, k5err);
+	free(k5err);
 	return retval;
 }
 
@@ -927,7 +927,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 				k5err = gssd_k5_err_msg(context, code);
 				printerr(1, "%s while building principal for '%s'\n",
 					 k5err, spn);
-				krb5_free_string(context, k5err);
+				free(k5err);
 				k5err = NULL;
 				continue;
 			}
@@ -937,7 +937,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 				k5err = gssd_k5_err_msg(context, code);
 				printerr(3, "%s while getting keytab entry for '%s'\n",
 					 k5err, spn);
-				krb5_free_string(context, k5err);
+				free(k5err);
 				k5err = NULL;
 				/*
 				 * We tried the active directory machine account
@@ -986,7 +986,7 @@ out:
 		k5_free_default_realm(context, default_realm);
 	if (realmnames)
 		krb5_free_host_realm(context, realmnames);
-	krb5_free_string(context, k5err);
+	free(k5err);
 	return retval;
 }
 
@@ -1355,7 +1355,7 @@ out_free_kt:
 out_free_context:
 	krb5_free_context(context);
 out:
-	krb5_free_string(context, k5err);
+	free(k5err);
 	return retval;
 }
 
-- 
2.26.2

