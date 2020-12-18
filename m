Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE72DE767
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Dec 2020 17:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgLRQYo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Dec 2020 11:24:44 -0500
Received: from smtp-o-3.desy.de ([131.169.56.156]:54148 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbgLRQYn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 18 Dec 2020 11:24:43 -0500
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [131.169.56.166])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 2A3A0607AA
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 17:23:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 2A3A0607AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1608308639; bh=pkfDd95qq6pSA+phV3k+pyL56rUpuFG3h+4j/UpgKgo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Pv24yFC283WXdfJMuKnv2twLnJxJd7Z42ESSe3oeq5UxB6yPDOiPUYcXb7/24DUW6
         MPJnfwn8uF8dwOT7M5k3+zJBENPu7BDnyxFwuAwZPp5rgCQY7xLgd2ZqeAFM5laRWN
         QrBQwCMm+CXsAHXWIp80p84jVZiA2U7E90pkrsug=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 2247AA05F1;
        Fri, 18 Dec 2020 17:23:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id EECB61001A7;
        Fri, 18 Dec 2020 17:23:58 +0100 (CET)
Date:   Fri, 18 Dec 2020 17:23:58 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Tom Haynes <loghyr@gmail.com>, bfields <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1510952492.5375434.1608308638350.JavaMail.zimbra@desy.de>
In-Reply-To: <20201218144605.GB1258@fieldses.org>
References: <20201217003516.75438-1-loghyr@hammerspace.com> <20201218144605.GB1258@fieldses.org>
Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Misc Fixes, primarily LAYOUTRETURN
Thread-Index: vLbl5msoHrbYKCrAhcnvWTsmB+v2qA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


I run the tests. They fail due to python3 incompatibility:

FFST1    st_flex.testStateid1                                     : PASS
FFLA1    st_flex.testFlexLayoutTestAccess                         : FAILURE
           Expected uid_rd != b'17', got b'17'
FFLG2    st_flex.testFlexLayoutStress                             : FAILURE
           TypeError: can only concatenate str (not "bytes") to
           str
FFLS3    st_flex.testFlexLayoutStatsStraight                      : FAILURE
           TypeError: can only concatenate str (not "bytes") to
           str
FFLS1    st_flex.testFlexLayoutStatsSmall                         : FAILURE
           TypeError: can't concat str to bytes
FFLS2    st_flex.testFlexLayoutStatsReset                         : FAILURE
           TypeError: can only concatenate str (not "bytes") to
           str
FFLS4    st_flex.testFlexLayoutStatsOverflow                      : FAILURE
           TypeError: can only concatenate str (not "bytes") to
           str
FFLORSTALEWRITE st_flex.testFlexLayoutReturnStaleWrite            : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_STALE, instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORSTALEREAD st_flex.testFlexLayoutReturnStaleRead              : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFLORSERVERFAULTWRITE st_flex.testFlexLayoutReturnServerFaultWrite : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_SERVERFAULT, instead got
           NFS4ERR_LAYOUTUNAVAILABLE
FFLORSERVERFAULTREAD st_flex.testFlexLayoutReturnServerFaultRead  : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFLORNXIOWRITE st_flex.testFlexLayoutReturnNxioWrite              : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_NXIO, instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORNXIOREAD st_flex.testFlexLayoutReturnNxioRead                : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFLORNOSPCWRITE st_flex.testFlexLayoutReturnNospcWrite            : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_NOSPC, instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORNOSPC st_flex.testFlexLayoutReturnNospcRead                  : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTUNAVAILABLE
FFLORIOWRITE st_flex.testFlexLayoutReturnIoWrite                  : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_IO, instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORIOREAD st_flex.testFlexLayoutReturnIoRead                    : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFLORFBIGWRITE st_flex.testFlexLayoutReturnFbigWrite              : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_FBIG, instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORFBIG st_flex.testFlexLayoutReturnFbigRead                    : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTUNAVAILABLE
FFLORDELAYWRITE st_flex.testFlexLayoutReturnDelayWrite            : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY,
           instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORDELAYREAD st_flex.testFlexLayoutReturnDelayRead              : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFLORACCESSWRITE st_flex.testFlexLayoutReturnAccessWrite          : FAILURE
           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
           NFS4ERR_ACCESS, instead got NFS4ERR_LAYOUTUNAVAILABLE
FFLORACCESSREAD st_flex.testFlexLayoutReturnAccessRead            : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFLOR100 st_flex.testFlexLayoutReturn100                          : FAILURE
           NameError: name 'xrange' is not defined
FFLOOS   st_flex.testFlexLayoutOldSeqid                           : FAILURE
           TypeError: can only concatenate str (not "bytes") to
           str
FFGLO1   st_flex.testFlexGetLayout                                : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
           NFS4ERR_LAYOUTTRYLATER
FFGDI1   st_flex.testFlexGetDevInfo                               : FAILURE
           TypeError: can only concatenate str (not "bytes") to
           str


Regards,
   Tigran.



----- Original Message -----
> From: "J. Bruce Fields" <bfields@fieldses.org>
> To: "Tom Haynes" <loghyr@gmail.com>
> Cc: "bfields" <bfields@redhat.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 18 December, 2020 15:46:05
> Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN

> On Wed, Dec 16, 2020 at 04:35:06PM -0800, Tom Haynes wrote:
>> Hi Bruce,
>> 
>> Here are a series of patches that Hamerspace has applied to the
>> flex files testing.
> 
> Thanks, applying.
> 
> I'm pretty hands-off when it comes to pynfs tests I don't personally
> run.  If they work for you then I'm probably fine with them....
> 
> --b.
> 
>> 
>> Thanks,
>> Tom
>> 
>> Jean Spector (2):
>>   st_flex.py - Added tests for LAYOUTRETURN with errors
>>   st_flex.py - Fixed flag names
>> 
>> Tom Haynes (7):
>>   Close the file for SEQ10b
>>   flexfiles: Fix up the layout error handling to reflect the previous
>>     error
>>   st_flex: Reduce the layoutstats period to make tests finish in a sane
>>     time
>>   st_flex: Fix up test names
>>   st_flex: Only do 100 layoutget/return in loop
>>   st_flex: We can't return the layout without a layout stateid
>>   st_flex: Fixup check for error in layoutget_return()
>> 
>> Trond Myklebust (1):
>>   Fix testFlexLayoutOldSeqid
>> 
>>  nfs4.1/server41tests/st_flex.py     | 651 +++++++++++++++++++++++++---
>>  nfs4.1/server41tests/st_sequence.py |   5 +
>>  2 files changed, 588 insertions(+), 68 deletions(-)
>> 
>> --
> > 2.26.2
