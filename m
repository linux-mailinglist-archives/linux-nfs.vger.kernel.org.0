Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3436F68F6
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 12:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjEDKQJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjEDKQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 06:16:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0AC46B7
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 03:16:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 04A661F8A4;
        Thu,  4 May 2023 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683195366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=B7DVxXBVVM6d5BjARHR9arHNn419fzOm2B2VZfl4v1g=;
        b=RfaBvKCC6m9xEj33naUewP0HyNlqxTIJFGPSE4Y56jXzrvTnZU+lhOWRcOkma8cLRzFmWA
        YxC30WLsuYI2sJ0BOxAxau3e/BvZL1M4kBPjSTKNDcKZ/Nn1/BjR6Uuoi03bX0j5voBDf/
        cX7NhzQlI+cxBZDN1ctM8A55pT1cAuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683195366;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=B7DVxXBVVM6d5BjARHR9arHNn419fzOm2B2VZfl4v1g=;
        b=PW9PY2xpufGo6tuj6GACNL0ttcfzxxWFpltNVCAHmaa+nDGUMS+P+ZE76IQim4uh/QTpSI
        /MAhIr1B7EFy2YAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC4E5133F7;
        Thu,  4 May 2023 10:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id odhbKOWFU2RXcwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 10:16:05 +0000
Date:   Thu, 4 May 2023 12:16:19 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Steve Dickson <steved@redhat.com>
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        ltp@lists.linux.it
Subject: LTP: tirpc_rpcb_rmtcall is failing
Message-ID: <20230504101619.GA3801922@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

tirpc_rpcb_rmtcall is failing. I was able to reproduce it on
* openSUSE Tumbleweed with libtirpc 1.3.3
* Debian stable  11 (bullseye) with libtirpc 1.3.1-1

OTOH SLE 15-SP4 with libtirpc 1.2.6 is working.

PATH="/opt/ltp/testcases/bin:$PATH" rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
rpc_test 1 TINFO: add local addr 10.0.0.2/24
rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
rpc_test 1 TINFO: add remote addr 10.0.0.1/24
rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
rpc_test 1 TINFO: Network config (local -- remote):
rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
rpc_test 1 TINFO: timeout per run is 0h 5m 0s
rpc_test 1 TINFO: check registered RPC with rpcinfo
rpc_test 1 TINFO: registered RPC:
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100024    1   udp  37966  status
    100024    1   tcp  43643  status
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100021    1   udp  59603  nlockmgr
    100021    3   udp  59603  nlockmgr
    100021    4   udp  59603  nlockmgr
    100021    1   tcp  39145  nlockmgr
    100021    3   tcp  39145  nlockmgr
    100021    4   tcp  39145  nlockmgr
rpc_test 1 TINFO: using libtirpc: yes
rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
1

The problem is in tirpc_rpcb_rmtcall.c [1], which calls rpcb_rmtcall(), which
returns 1 (I suppose RPC_CANTENCODEARGS - can't encode arguments - enum
clnt_stat from tirpc/rpc/clnt_stat.h):

	cs = rpcb_rmtcall(nconf, argc[1], progNum, VERSNUM, PROCNUM,
			  (xdrproc_t) xdr_int, (char *)&var_snd,
			  (xdrproc_t) xdr_int, (char *)&var_rec, tv, &svcaddr);

	test_status = (cs == RPC_SUCCESS) ? 0 : 1;

	//This last printf gives the result status to the tests suite
	//normally should be 0: test has passed or 1: test has failed
	printf("%d\n", test_status);

	return test_status;

Any idea what could be wrong with these very old tests?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/12765c115f11026c090ab0ee5dd79b38d95ef31f/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c#L91-L93
