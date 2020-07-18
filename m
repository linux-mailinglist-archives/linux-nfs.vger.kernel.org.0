Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB445224A35
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGRJY6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:58 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:35913 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbgGRJY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:56 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0000Sm-Ot
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BmwDqrToiA5rcykhQBQg6s9zAW/J0oVj76c+yMppcYg=; b=h/261Dgj3epoBHyRXWRUS9t3Za
        oz0jadZMRke46wskcrKg9/K3tCEGih9Kfb4XZbIcnACCcGDjSJFt9O6YTKjCKdlrI7PSM51h/reIG
        BV1PAQGiDrWJEBd6SIxDEPDBh51pVfdfFYKShzBkkSZJXu10k46eQQgbbKZgMgukpDtNjgL1kou2g
        tdpU0cSRx03A/4M7HoftNo9RahvfbHP/eC0/q7g8Q8inVbBqIEzg3cYBuhAFVk22VC1xGGSxQqlY9
        k2477KlR1l1nSdT4yLOTbJgYM1EgCK4DId+UXyBpDOug7oIH2fVxc68QhNXhcB02RLXVRgAzNGpMo
        09D4XUpg==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0001He-J0
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:50 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/11] svcgssd: Cleanup global resources on exit
Date:   Sat, 18 Jul 2020 05:24:20 -0400
Message-Id: <20200718092421.31691-11-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718092421.31691-1-nazard@nazar.ca>
References: <20200718092421.31691-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00347005858379)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVsXPoCAMOxEQH
 WK0lbi4wjUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIt5JO0xMwGZ5FJWHB0WU4rsl7H6aAPMkVWPpyCe5BmaHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrh5vLcHJlfkxRx57lV8TACa39nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNO0eLTyIuJf+IqbzABHTTcVsxM6U7LHRrBHwTdA1aWtZjEa/sNl+vcoDGoY
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
 utils/gssd/gss_util.c     |  6 ++++++
 utils/gssd/gss_util.h     |  1 +
 utils/gssd/svcgssd.c      |  8 ++++++++
 utils/gssd/svcgssd_krb5.c | 21 ++++++++++++++-------
 utils/gssd/svcgssd_krb5.h |  1 +
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/utils/gssd/gss_util.c b/utils/gssd/gss_util.c
index 2e6d40f0..a4b27779 100644
--- a/utils/gssd/gss_util.c
+++ b/utils/gssd/gss_util.c
@@ -339,3 +339,9 @@ out:
 	return retval;
 }
 
+void
+gssd_cleanup(void)
+{
+	u_int32_t min_stat;
+	gss_release_cred(&min_stat, &gssd_creds);
+}
diff --git a/utils/gssd/gss_util.h b/utils/gssd/gss_util.h
index aa9f7780..4da64e38 100644
--- a/utils/gssd/gss_util.h
+++ b/utils/gssd/gss_util.h
@@ -41,6 +41,7 @@ int gssd_acquire_cred(char *server_name, const gss_OID oid);
 void pgsserr(char *msg, u_int32_t maj_stat, u_int32_t min_stat,
 	const gss_OID mech);
 int gssd_check_mechs(void);
+void gssd_cleanup(void);
 
 #ifndef HAVE_LIBGSSGLUE
 #include <gssapi/gssapi_krb5.h>
diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
index f538fd2a..3155a2f9 100644
--- a/utils/gssd/svcgssd.c
+++ b/utils/gssd/svcgssd.c
@@ -65,6 +65,7 @@
 #include "err_util.h"
 #include "conffile.h"
 #include "misc.h"
+#include "svcgssd_krb5.h"
 
 struct state_paths etab;
 static bool signal_received = false;
@@ -148,6 +149,9 @@ main(int argc, char *argv[])
 	rpc_verbosity = conf_get_num("svcgssd", "RPC-Verbosity", rpc_verbosity);
 	idmap_verbosity = conf_get_num("svcgssd", "IDMAP-Verbosity", idmap_verbosity);
 
+	/* We don't need the config anymore */
+	conf_cleanup();
+
 	while ((opt = getopt(argc, argv, "fivrnp:")) != -1) {
 		switch (opt) {
 			case 'f':
@@ -276,5 +280,9 @@ main(int argc, char *argv[])
 
 	event_base_free(evbase);
 
+	nfs4_term_name_mapping();
+	svcgssd_free_enctypes();
+	gssd_cleanup();
+
 	return EXIT_SUCCESS;
 }
diff --git a/utils/gssd/svcgssd_krb5.c b/utils/gssd/svcgssd_krb5.c
index 1d44d344..305d4751 100644
--- a/utils/gssd/svcgssd_krb5.c
+++ b/utils/gssd/svcgssd_krb5.c
@@ -74,13 +74,7 @@ parse_enctypes(char *enctypes)
 		return 0;
 
 	/* Free any existing cached_enctypes */
-	free(cached_enctypes);
-
-	if (parsed_enctypes != NULL) {
-		free(parsed_enctypes);
-		parsed_enctypes = NULL;
-		parsed_num_enctypes = 0;
-	}
+	svcgssd_free_enctypes();
 
 	/* count the number of commas */
 	for (curr = enctypes; curr && *curr != '\0'; curr = ++comma) {
@@ -162,6 +156,19 @@ out_clean_parsed:
 /*===  External routines ===*/
 /*==========================*/
 
+void
+svcgssd_free_enctypes(void)
+{
+	free(cached_enctypes);
+	cached_enctypes = NULL;
+
+	if (parsed_enctypes != NULL) {
+		free(parsed_enctypes);
+		parsed_enctypes = NULL;
+		parsed_num_enctypes = 0;
+	}
+}
+
 /*
  * Get encryption types supported by the kernel, and then
  * call gss_krb5_set_allowable_enctypes() to limit the
diff --git a/utils/gssd/svcgssd_krb5.h b/utils/gssd/svcgssd_krb5.h
index 07d5eb9b..78a90e9a 100644
--- a/utils/gssd/svcgssd_krb5.h
+++ b/utils/gssd/svcgssd_krb5.h
@@ -32,5 +32,6 @@
 #define SVCGSSD_KRB5_H
 
 int svcgssd_limit_krb5_enctypes(void);
+void svcgssd_free_enctypes(void);
 
 #endif /* SVCGSSD_KRB5_H */
-- 
2.26.2

