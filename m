Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7A693A89
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Feb 2023 23:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBLWp7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Feb 2023 17:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLWp6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Feb 2023 17:45:58 -0500
Received: from out28-43.mail.aliyun.com (out28-43.mail.aliyun.com [115.124.28.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CFBBA1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Feb 2023 14:45:55 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04713976|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0245653-0.00133269-0.974102;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.RK4K4mr_1676241952;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RK4K4mr_1676241952)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 06:45:53 +0800
Date:   Mon, 13 Feb 2023 06:45:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: question about the performance impact of sec=krb5
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
In-Reply-To: <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com> <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
Message-Id: <20230213064552.3960.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> 
> 
> > On Feb 12, 2023, at 1:01 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > Hi,
> > 
> > question about the performance of sec=krb5.
> > 
> > https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-impact-kerberos
> > Performance impact of krb5:
> > 	Average IOPS decreased by 53%
> > 	Average throughput decreased by 53%
> > 	Average latency increased by 3.2 ms
> 
> Looking at the numbers in this article... they don't
> seem quite right. Here are the others:
> 
> > Performance impact of krb5i:
> > 	? Average IOPS decreased by 55%
> > 	? Average throughput decreased by 55%
> > 	? Average latency increased by 0.6 ms
> > Performance impact of krb5p:
> > 	? Average IOPS decreased by 77%
> > 	? Average throughput decreased by 77%
> > 	? Average latency increased by 1.6 ms
> 
> I would expect krb5p to be the worst in terms of
> latency. And I would like to see round-trip numbers
> reported: what part of the increase in latency is
> due to server versus client processing?
> 
> This is also remarkable:
> 
> > When nconnect is used in Linux, the GSS security context is shared between all the nconnect connections to a particular server. TCP is a reliable transport that supports out-of-order packet delivery to deal with out-of-order packets in a GSS stream, using a sliding window of sequence numbers.?When packets not in the sequence window are received, the security context is discarded, and?a new security context is negotiated. All messages sent with in the now-discarded context are no longer valid, thus requiring the messages to be sent again. Larger number of packets in an nconnect setup cause frequent out-of-window packets, triggering the described behavior. No specific degradation percentages can be stated with this behavior.
> 
> 
> So, does this mean that nconnect makes the GSS sequence
> window problem worse, or that when a window underrun
> occurs it has broader impact because multiple connections
> are affected?
> 
> Seems like maybe nconnect should set up a unique GSS
> context for each xprt. It would be helpful to file a bug.
> 
> 
> > and then in 'man 5 nfs'
> > sec=krb5  provides cryptographic proof of a user's identity in each RPC request.
> 
> Kerberos has performance impacts due to the crypto-
> graphic operations that are performed on even small
> fixed-sized sections of each RPC message, when using
> sec=krb5 (no 'i' or 'p').
> 
> 
> > Is there a option of better performance to check krb5 only when mount.nfs4,
> > not when file acess?
> 
> If you mount with NFSv4 and sec=sys from a Linux NFS
> client that has a keytab, the client will attempt to
> use krb5i for lease management operations (such as
> EXCHANGE_ID) but it will continue to use sec=sys for
> user authentication. That's not terribly secure.

I noticed this feature in this case
- the nfs client joined the windows AD(then have a keytab)
- the windows AD server is shutdown.
then 'mount.nfs4 -o sec=sys' will take about 3 min.
because there are 60s timeout  *3 inside.
but 'sec=sys' does not need any krb5 operations?

maybe we can have another krb5 mode, such as 'krb5l'
- the nfs client must have a keytab.
- krb5 must be used only when mount.nfs4
It would be more secure than IP address check in /etc/exorts?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/13


> 
> A better answer would be to make Kerberos faster.
> I've done some recent work on improving the overhead
> of using message digest algorithms with GSS-API, but
> haven't done any specific measurement. I'm sure
> there's more room for optimization.
> 
> Even better would be to use a transport layer security
> service. Amazon has EFS and Oracle Cloud has something
> similar, but we're working on a standard approach that
> uses TLSv1.3.
> 
> 
> --
> Chuck Lever
> 
> 
> 


