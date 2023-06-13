Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9243372D839
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jun 2023 05:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjFMDqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 23:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFMDqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 23:46:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EBB4
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 20:46:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CC5933200913;
        Mon, 12 Jun 2023 23:46:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 12 Jun 2023 23:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nubmail.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1686627991; x=
        1686714391; bh=iH1h2NrrphK3sn1s4pS2s9yjaVdW93PrKjQsi+VjOYM=; b=x
        JJoDSkxCBYcGDYnLMO+pJG4ifkFQQJ4bGZ5Z5PhlnaBc0HtEvKbYjzulhNABE+UB
        O2ICbGsdtTXVRnYxQad0TX6vBjCHFe4Ow4SOeLXOlO7Ly2rEzMDFGfGoFweH0UVC
        rQQ9HajtoaJZqaWO2yQY+px3h2uOSa1Q4mzo18nqP498JhDu2FJ08VJvvltd8vnb
        w1zhiFi6TGSCemOGzv4k+6APJuifI7QR70vcV2TJhmP9nV6bVM6VdLKRfJusi7V/
        99ZbuJVT0s/Dxa2Blsn1MXYY+C188byvMqGF8uWVt2kKzsL6AV5DP+5j0a32GA4S
        Bung4cZkavQXa28uN1qdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1686627991; x=
        1686714391; bh=iH1h2NrrphK3sn1s4pS2s9yjaVdW93PrKjQsi+VjOYM=; b=G
        XnxzC7I4uUVqOKZe2hg+o1Y4/KmkAy5BvAUC1WvB0or/UnBKRgs0kIKpO+A8vxcq
        X0Yb7gWh5S1VoLuGGFunkgrRb6/zBvbqHerdreSAgxB8WC6TtI1fKQ8UEo3XZ9az
        6KyYE9a9wyOcubNVX6Vo6WYFnI03UsXDs4J8yQ45oDxOfWjlGUDJRbz2loKRr2Mz
        RlQarrPF9ByCJvm9QlpJoAOrFWndj11g1gcj1Ope6VORHk2YgdvJuF99VKimugbp
        vvFluJK6WnWoem+ZPty4JqcCmg23qj8dTsv4zowKfEq7HuSqeFgPkOgfBVAWV/0O
        h+WcIMNn/fyTpu/dVKf1w==
X-ME-Sender: <xms:l-aHZDtsmoFoZpZvBSwdGb65gW1FrjwURX60-wFPf7DHcBwKFvQmOA>
    <xme:l-aHZEczVyQYquzcewAN8Qc7nVefWfI82ncRccvW8jlWt1Cx2iANAeMPEJxnlFesY
    5rM72CYVWNVUFGWNqM>
X-ME-Received: <xmr:l-aHZGz3BqAINGKwEMFJmJdSWJyBaUrY2whbB9Y1yJSQPcCztM46kLGyZcgM9LxeeJKzgCmCssnyRBlOCdhbnudlznX5HRgoEpW3di8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduiedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetrhgrmhcutehkhhgrvhgrnhcuoehgihhthhhusgesrghr
    rghmrdhnuhgsmhgrihhlrdgtrgeqnecuggftrfgrthhtvghrnhepheejudefhffftdfgud
    ejffffiedufedtleehffegteeiveejgfeffefhkeduvddtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhhuhgssegrrhgrmhdrnhhusg
    hmrghilhdrtggr
X-ME-Proxy: <xmx:l-aHZCPNtWkNdToc8ko899_9WuzJdiuiV0vGMlp0LOWfVWO2VlwoGw>
    <xmx:l-aHZD-OPQuRhkZMmJ_tEUq4eZis-Ua0QD11r-MXYc6PdUcUasQJwQ>
    <xmx:l-aHZCXH_FsLENV4opNaZiaii4oSd6iwsYpkFM86OHReS-f-kVW-fQ>
    <xmx:l-aHZALoHcrjVMLqNnONj9yhyjp5VHzjJH8iFIH1FfAcbgrLHMdzWw>
Feedback-ID: i8ce9446d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 23:46:30 -0400 (EDT)
From:   Aram Akhavan <github@aram.nubmail.ca>
To:     linux-nfs@vger.kernel.org
Cc:     Aram Akhavan <github@aram.nubmail.ca>
Subject: [PATCH 2/2] libnfsidmap: try to get the domain directly from hostname if the DNS lookup fails and always show the log message if the domain can't be determined
Date:   Mon, 12 Jun 2023 20:46:25 -0700
Message-Id: <20230613034625.498132-3-github@aram.nubmail.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613034625.498132-1-github@aram.nubmail.ca>
References: <20230613034625.498132-1-github@aram.nubmail.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs4_init_name_mapping(), if no domain is specified in the config file, the hostname will be looked up in DNS, and the domain extracted from that.
If DNS resolution isn't up at this time (i.e. on idmapd startup), the hardcoded domain in IDMAPD_DEFAULT_DOMAIN is used. This will break id mapping
for anyone who doesn't happen to use "localdomain". Previously, the log message indicating this has happened requires -v to be passed, so the
"failure" was silent by default.

Signed-off-by: Aram Akhavan <github@aram.nubmail.ca>
---
 support/nfsidmap/libnfsidmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index 0a912e52..f8c36480 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -219,10 +219,15 @@ static int domain_from_dns(char **domain)
 
 	if (gethostname(hname, sizeof(hname)) == -1)
 		return -1;
-	if ((he = gethostbyname(hname)) == NULL)
-		return -1;
-	if ((c = strchr(he->h_name, '.')) == NULL || *++c == '\0')
-		return -1;
+	if ((he = gethostbyname(hname)) == NULL) {
+		IDMAP_LOG(1, ("libnfsidmap: DNS lookup of hostname failed. Attempting to use domain from hostname as is."));
+		if ((c = strchr(hname, '.')) == NULL || *++c == '\0')
+			return -1;
+	}
+	else {
+		if ((c = strchr(he->h_name, '.')) == NULL || *++c == '\0')
+			return -1;
+	}
 	/* 
 	 * Query DNS to see if the _nfsv4idmapdomain TXT record exists
 	 * If so use it... 
@@ -387,7 +392,7 @@ int nfs4_init_name_mapping(char *conffile)
 		dflt = 1;
 		ret = domain_from_dns(&default_domain);
 		if (ret) {
-			IDMAP_LOG(1, ("libnfsidmap: Unable to determine "
+			IDMAP_LOG(0, ("libnfsidmap: Unable to determine "
 				  "the NFSv4 domain; Using '%s' as the NFSv4 domain "
 				  "which means UIDs will be mapped to the 'Nobody-User' "
 				  "user defined in %s", 
-- 
2.39.2

