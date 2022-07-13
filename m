Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF24457368A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiGMMn6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiGMMn6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 08:43:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2AD1837B
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 05:43:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E8E633CDA;
        Wed, 13 Jul 2022 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657716235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qtU2LYuWGCdHcSk84T3OFycnSGsg9Lg6xIJMBpa98E8=;
        b=eQ4+0dT1iX0tiulMM9+xiLtVXqFkNfku3PdARKvjq3Zvv6N8lP5XDUQah/aIVvIFwOnUK2
        +Wlkfra6s3kZNTFrqfpXSW2ZMSZ1IkmqitIdg+l/1C2joG3GZqHNsFWcj9I2tOEnHBNgmh
        YYjnrTmcszIZEh1bqN2mKbyQa58WtMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657716235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qtU2LYuWGCdHcSk84T3OFycnSGsg9Lg6xIJMBpa98E8=;
        b=tKBvlfsRqnEyeV+NbNoZTU7UL8G9kWD6l4jPifRYHqsJGtwp2fZwk/2cEljXn9XuhDSab4
        RBaJJbsjfz8MD0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4554713AAD;
        Wed, 13 Jul 2022 12:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qnfhDQu+zmKHLwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 13 Jul 2022 12:43:55 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>,
        Martin Doucha <mdoucha@suse.cz>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH 1/1] netstress: Restore runtime to 5m
Date:   Wed, 13 Jul 2022 14:43:47 +0200
Message-Id: <20220713124347.13593-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

netstress requires the previous default timeout 5m due longer timeout
for higher message sizes (e.g. 65535):

./sctp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535:R65535
sctp_ipsec 1 TPASS: netstress passed, median time 5 ms, data: 5 9 6 5 5
sctp_ipsec 2 TINFO: run server 'netstress -T sctp -S fd00:1:1:1::1 -D ltp_ns_veth1 -R 500000 -B /tmp/LTP_sctp_ipsec.ARZbGkvjPa'
sctp_ipsec 2 TINFO: run client 'netstress -l -T sctp -H fd00:1:1:1::1 -n 1000 -N 1000 -S fd00:1:1:1::2 -D ltp_ns_veth2 -a 2 -r 100 -d /tmp/LTP_sctp_ipsec.ARZbGkvjPa/tst_netload.res' 5 times
sctp_ipsec 2 TPASS: netstress passed, median time 6 ms, data: 8 6 6 5 6
sctp_ipsec 3 TINFO: run server 'netstress -T sctp -S fd00:1:1:1::1 -D ltp_ns_veth1 -R 500000 -B /tmp/LTP_sctp_ipsec.ARZbGkvjPa'
sctp_ipsec 3 TINFO: run client 'netstress -l -T sctp -H fd00:1:1:1::1 -n 65535 -N 65535 -S fd00:1:1:1::2 -D ltp_ns_veth2 -a 2 -r 100 -d /tmp/LTP_sctp_ipsec.ARZbGkvjPa/tst_netload.res' 5 times
sctp_ipsec 3 TWARN: netstress failed, ret: 2
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
netstress.c:896: TINFO: IP_BIND_ADDRESS_NO_PORT is used
netstress.c:898: TINFO: connection: addr 'fd00:1:1:1::1', port '55097'
netstress.c:900: TINFO: client max req: 100
netstress.c:901: TINFO: clients num: 2
netstress.c:906: TINFO: client msg size: 65535
netstress.c:907: TINFO: server msg size: 65535
netstress.c:979: TINFO: SCTP client
netstress.c:475: TINFO: Running the test over IPv6
Test timeouted, sending SIGKILL!
tst_test.c:1577: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1579: TBROK: Test killed! (timeout?)

Converting netstress.c to use TST_NO_DEFAULT_MAIN (i.e. implementing main)
would require more changes, because it uses .forks_child, .needs_checkpoints,
cleanup function.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: there is also needed to increase timeout for sctp_ipsec.sh.
At least on my VM 10 min wasn't enough. Trying to measure reasonable
time with TST_TIMEOUT=-1.

Kind regards,
Petr

 testcases/network/netstress/netstress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 6c9e83112..7c222531d 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -1028,5 +1028,6 @@ static struct tst_test test = {
 		{"B:", &server_bg, "Run in background, arg is the process directory"},
 		{}
 	},
+	.max_runtime = 300,
 	.needs_checkpoints = 1,
 };
-- 
2.37.0

