Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384FC224A3B
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGRJZE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:25:04 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:48183 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgGRJYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:55 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0000SC-8x
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v0kurMK/ZUC7qx5SQ+lyXBtKt28tlgQXtsg7/5/PdII=; b=oAq0KGapkmbZwwJqAm6ZiXRgM4
        XmILC/TbgXm0tfFJxLlwjtKDPgVz32HNJk20/RtJrw+SyqLVFNEkHO495QERjklM3crf9zJZB1FU4
        0bfApzyjb04TMXRQx0Nv0Lv15+n4ph1E+Bhnt3CydDpa+UiPfaB5/MK1V8rbIudspnOuaADo5EQ71
        qlWe2WusHX+u93U0MxepMuhzlDActZkfNjvy6evvPlodUPgq1cEAEz4h9QklS9aZdMrdjgWAls1Yd
        m1vLYR/yIm/baT4FV3ajj9/7E07vLojE9L8ZazVaVVKKyQG4QvMflhTiGqf9So84f5B5+nNGu5/1q
        Ri77/s7g==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0001He-32
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:50 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/11] nfsdcld: Don't copy more data than exists in column
Date:   Sat, 18 Jul 2020 05:24:17 -0400
Message-Id: <20200718092421.31691-8-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVvTiRJS640Vnd
 UT9/wyIMcUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJwbzv+0Jw40N8ixiE7liftSmUdrTUTyMaf7yDXP6F1VHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSN2
 /dCl07HvV0uIlTJ4mU8A9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5hULXT
 QWBFtnc6haN5SI3fviDbZu1CSBDRNpnLIZiVmOz5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Found with valgrind.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/nfsdcld/sqlite.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 8fd1d0c2..03016fb9 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -1330,20 +1330,26 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 	}
 
 	while ((ret = sqlite3_step(stmt)) == SQLITE_ROW) {
+		const void *id;
+		int id_len;
+
+		id = sqlite3_column_blob(stmt, 0);
+		id_len = sqlite3_column_bytes(stmt, 0);
+		if (id_len > NFS4_OPAQUE_LIMIT)
+			id_len = NFS4_OPAQUE_LIMIT;
+
 		memset(&cmsg->cm_u, 0, sizeof(cmsg->cm_u));
 #if UPCALL_VERSION >= 2
-		memcpy(&cmsg->cm_u.cm_clntinfo.cc_name.cn_id,
-			sqlite3_column_blob(stmt, 0), NFS4_OPAQUE_LIMIT);
-		cmsg->cm_u.cm_clntinfo.cc_name.cn_len = sqlite3_column_bytes(stmt, 0);
+		memcpy(&cmsg->cm_u.cm_clntinfo.cc_name.cn_id, id, id_len);
+		cmsg->cm_u.cm_clntinfo.cc_name.cn_len = id_len;
 		if (sqlite3_column_bytes(stmt, 1) > 0) {
 			memcpy(&cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
 				sqlite3_column_blob(stmt, 1), SHA256_DIGEST_SIZE);
 			cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = sqlite3_column_bytes(stmt, 1);
 		}
 #else
-		memcpy(&cmsg->cm_u.cm_name.cn_id, sqlite3_column_blob(stmt, 0),
-			NFS4_OPAQUE_LIMIT);
-		cmsg->cm_u.cm_name.cn_len = sqlite3_column_bytes(stmt, 0);
+		memcpy(&cmsg->cm_u.cm_name.cn_id, id, id_len);
+		cmsg->cm_u.cm_name.cn_len = id_len;
 #endif
 		cb(clnt);
 	}
-- 
2.26.2

