Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B66D9CCB
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbjDFPyQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbjDFPyN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 11:54:13 -0400
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635130F9
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 08:54:12 -0700 (PDT)
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
        by phd-imap.ethz.ch (Postfix) with ESMTP id 4PsmJf6qz0z36;
        Thu,  6 Apr 2023 17:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
        s=2023; t=1680796450;
        bh=84exzpXs2h7NbzQa0nPOV7KezBcEJj5G48CmH3a6H3Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oIWcUco5+x0d0gouegmO6NCpJgYJGejvpiZDHh4kERxZuB8+wfoDzjrx1Ft7aUyZv
         hLvUkgyYvmv03oN1UazDrzyxAuIpaOFfjkiSkiKIrAcTZC9ShuZzdiHlq7a4MBtvo5
         QIbR11zaLPJzsvCpHr9V1xCTu2ocikGZMQ0NxvtKS5aKSeaBtrv5Nm0aLTX2NxitY3
         ynrlK8XZ2fz2dFb77XCEpJbSrYK1ejl9+x8eM+fpocKMlj1IEQC2soItjvPeals/gZ
         Ji+pFmRRGXDQnrAd92/CvdEnFDiuceeRO/jXNpfqOoRNBhZLpCBKNhnKQcDD60f3Wk
         Pk1tl5X34Tvew==
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
        by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
        with LMTP id XHpM-dNNITQ6; Thu,  6 Apr 2023 17:54:10 +0200 (CEST)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daduke@phd-mxin.ethz.ch)
        by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4PsmJf61GPz9x;
        Thu,  6 Apr 2023 17:54:10 +0200 (CEST)
Date:   Thu, 6 Apr 2023 17:54:09 +0200
From:   Christian Herzog <herzog@phys.ethz.ch>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Message-ID: <ZC7rIWmrxTKSvFAi@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
References: <ZC6oX7FxdJd86rF7@phys.ethz.ch>
 <6785EFE7-2CE1-45CD-8643-C40CCCDADEB8@oracle.com>
 <ZC7mOH4I3roIM4xr@phys.ethz.ch>
 <478CD009-C11B-46F2-AD13-689953D612ED@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478CD009-C11B-46F2-AD13-689953D612ED@oracle.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Chuck,

> > That was our first idea too, but we haven't found any indication that this is the case. The xfs file systems seem perfectly fine when all nfsds are in D state, and we can
> > read from them and write to them. If xfs were to block nfs IO, this should
> > affect other processes too, right?
> 
> It's possible that the NFSD threads are waiting on I/O to a particular filesystem block. XFS is not likely to block other activity in this case.
ok good to know. So far we were under the impression that a file system would
block as a whole.

> I'm merely suggesting that you should start troubleshooting at the bottom of the stack instead of the top. The wait is far outside the realm of NFSD.
thanks, point taken. So next time it happens we'll make sure to poke in this
direction during the few minutes we have for debugging before we get tarred
and feathered by the users.


-Christian


-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/
