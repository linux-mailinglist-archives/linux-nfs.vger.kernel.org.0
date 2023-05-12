Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815C7001AC
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 09:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjELHnV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjELHnU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 03:43:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADC6EA1
        for <linux-nfs@vger.kernel.org>; Fri, 12 May 2023 00:43:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2F72270C;
        Fri, 12 May 2023 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683877396;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksU5ZKw3Kio2TGZdZRZ7Uxl4HNVyHbnXk7iE+i0ikA8=;
        b=hh5pW3r+I1joUeRXkqHRPrnYH3qBrMVxzyI4wTwKfvq0PcTD1L2arLlGmiv+LRteTOXoPw
        EhAVi04HZ9pcWOeSfyK6WuEO6knUT7pIHTJnk+PftwnMoxwUSj2jN+skChEfyVKYk4dZXm
        Q6Rca7HIlR+lopJ0icGlsmTEmvQUIbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683877396;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksU5ZKw3Kio2TGZdZRZ7Uxl4HNVyHbnXk7iE+i0ikA8=;
        b=MFqkMqwQSrKDO8dNfDKo+Lpd06IUMbANWseBEaEPmL6q5GtRMvruKb5xSCoDvz8zlNw+yv
        3KmacVvImhZHzCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C91413466;
        Fri, 12 May 2023 07:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1rvkDRTuXWSoCwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 12 May 2023 07:43:16 +0000
Date:   Fri, 12 May 2023 09:43:14 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Steve Dickson <steved@redhat.com>
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: LTP: tirpc_rpcb_rmtcall is failing
Message-ID: <20230512074314.GB30010@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230504101619.GA3801922@pevik>
 <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

> Hello Petr,

> On 5/4/23 6:16 AM, Petr Vorel wrote:
> > Hi Steve,

> > tirpc_rpcb_rmtcall is failing. I was able to reproduce it on
> > * openSUSE Tumbleweed with libtirpc 1.3.3
> > * Debian stable  11 (bullseye) with libtirpc 1.3.1-1

> > OTOH SLE 15-SP4 with libtirpc 1.2.6 is working.

> > PATH="/opt/ltp/testcases/bin:$PATH" rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> > rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > rpc_test 1 TINFO: add local addr 10.0.0.2/24
> > rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
> > rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > rpc_test 1 TINFO: add remote addr 10.0.0.1/24
> > rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
> > rpc_test 1 TINFO: Network config (local -- remote):
> > rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > rpc_test 1 TINFO: timeout per run is 0h 5m 0s
> > rpc_test 1 TINFO: check registered RPC with rpcinfo
> > rpc_test 1 TINFO: registered RPC:
> >     program vers proto   port  service
> >      100000    4   tcp    111  portmapper
> >      100000    3   tcp    111  portmapper
> >      100000    2   tcp    111  portmapper
> >      100000    4   udp    111  portmapper
> >      100000    3   udp    111  portmapper
> >      100000    2   udp    111  portmapper
> >      100005    1   udp  20048  mountd
> >      100005    1   tcp  20048  mountd
> >      100005    2   udp  20048  mountd
> >      100005    2   tcp  20048  mountd
> >      100005    3   udp  20048  mountd
> >      100005    3   tcp  20048  mountd
> >      100024    1   udp  37966  status
> >      100024    1   tcp  43643  status
> >      100003    3   tcp   2049  nfs
> >      100003    4   tcp   2049  nfs
> >      100227    3   tcp   2049  nfs_acl
> >      100021    1   udp  59603  nlockmgr
> >      100021    3   udp  59603  nlockmgr
> >      100021    4   udp  59603  nlockmgr
> >      100021    1   tcp  39145  nlockmgr
> >      100021    3   tcp  39145  nlockmgr
> >      100021    4   tcp  39145  nlockmgr
> > rpc_test 1 TINFO: using libtirpc: yes
> > rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> > 1

> > The problem is in tirpc_rpcb_rmtcall.c [1], which calls rpcb_rmtcall(), which
> > returns 1 (I suppose RPC_CANTENCODEARGS - can't encode arguments - enum
> > clnt_stat from tirpc/rpc/clnt_stat.h):

> > 	cs = rpcb_rmtcall(nconf, argc[1], progNum, VERSNUM, PROCNUM,
> > 			  (xdrproc_t) xdr_int, (char *)&var_snd,
> > 			  (xdrproc_t) xdr_int, (char *)&var_rec, tv, &svcaddr);

> > 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;

> > 	//This last printf gives the result status to the tests suite
> > 	//normally should be 0: test has passed or 1: test has failed
> > 	printf("%d\n", test_status);

> > 	return test_status;

> > Any idea what could be wrong with these very old tests?
> No... No idea... but I'm unable to reproduce it. It appears
> you are using different repo that the one I found on
> github [1]. But...

Thanks a lot for looking into the issue.
BTW on which Fedora/RHEL/CentOS version did you test?

No, I'm also using the official LTP repository on github [1].
And I compile on recent glibc (> 2.32, which removed SUN-RPC) and with libtirpc:

./configure
...
libtirpc: yes
glibc SUN-RPC: no

> Looking code, RPC_CANTENCODEARGS is returned when
> there is an xdr problem which might means a
> memory problem??

> With that said... commits 21718bbb^..fa153d63 did
That was released on 1.3.3, but I'm able to reproduce it on
Debian stable  11 (bullseye) with libtirpc 1.3.1-1.

Kind regards,
Petr

> make a lot of changes in the locking and cache
> management.

> steved.

> [1] https://github.com/linux-test-project/ltp

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/blob/12765c115f11026c090ab0ee5dd79b38d95ef31f/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c#L91-L93


