Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6D2DE787
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Dec 2020 17:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgLRQji (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Dec 2020 11:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731549AbgLRQji (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Dec 2020 11:39:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F9C0617B0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 08:38:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q4so1676046plr.7
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5Lnwl7jSG3nj7Z1wByWFLvvSQoQn+ORVzYdeGhsYPUk=;
        b=q/+aRJwE77+IJJD+lBYVsKfxozCKaTNRTF9URkJ5XOp0cI0KyFxy5nZDJbOwm3j0kj
         dmXYjTNv1nTmUjPsckO7vTt9CJZvlAFXKzpTeS/DiKy9QhFcMBLfh+KHJWWideB/EDI9
         e6EveGDf0FGpgPaCSplqjOBowVK+7NKZC/e1bDcR5nSL84ZczAeuIC65kqSkWA90R0aM
         HO0PkdA3zF+I/1XGDgc73GoFoqMF/EWIl3GAviZWDkvA+pCxDL580bcJDr/MDjYmO0zF
         SIKNulBG2sLyJQY4r3xMSSDEX8NiKYNKK+94CynLpLmr94nNHZsFwYPfYKLSyZkFlxTk
         ej4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5Lnwl7jSG3nj7Z1wByWFLvvSQoQn+ORVzYdeGhsYPUk=;
        b=NaNQUEP67Z9+9O8q6xjQskPscG8HlxFqen118QNn+GorvGEnvAAlFKfVNmhlnjTWjn
         W3ESzu6Vu+6S59NG23CHty/sYwF4/jwY7eGh37BeBKM6gFmKh4Ya4ipTDlIyFWim4eku
         8cXiDmiDD8DNgUym3GI8OpZGLlQYjom6MpmKbkscYX66ld65+FUWl47kuQxi0xjvs8bh
         mpyaCBo7K5hzlb5pWRUsKhT5Qtka67zOy0gH7evym6FXzxbDFJgIe+ZC1VfafqiCW73M
         sPs9levxNvSGxbuh1D4L7LewVh39YudmJw95hhJBiBPzMRg+hA//JEaT+qj9OTdWcIWU
         nNQw==
X-Gm-Message-State: AOAM530fHoPJT0Ls3bMtaIZZZ4FWoGEHCEIAy4o4+qgYTKkVKDttlgKN
        /bwFqxkw4GHIXbsAo5Z/YP8=
X-Google-Smtp-Source: ABdhPJw/9vGF3wLcEuD+KRRxV3HGJV0u1XPe05zCYOaMaI8Kmw5er0rcyvyHOcG0j9vR7SG4bgNtAQ==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr5188488pjs.102.1608309537225;
        Fri, 18 Dec 2020 08:38:57 -0800 (PST)
Received: from loghyr.internal.excfb.com (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id gm18sm8039610pjb.55.2020.12.18.08.38.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:38:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
From:   Thomas Haynes <loghyr@gmail.com>
In-Reply-To: <20201218163721.GC1258@fieldses.org>
Date:   Fri, 18 Dec 2020 08:38:54 -0800
Cc:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
        Bruce Fields <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <129D549F-66DC-43FE-B303-042442CDAAC8@gmail.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
 <20201218144605.GB1258@fieldses.org>
 <1510952492.5375434.1608308638350.JavaMail.zimbra@desy.de>
 <20201218163721.GC1258@fieldses.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2020, at 8:37 AM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Dec 18, 2020 at 05:23:58PM +0100, Mkrtchyan, Tigran wrote:
>>=20
>> I run the tests. They fail due to python3 incompatibility:
>=20
> Thanks!  I can't reproduce these, I assume because they're failing too
> early?:
>=20
> FFLA1    st_flex.testFlexLayoutTestAccess                         : =
RUNNING
> FFLA1    st_flex.testFlexLayoutTestAccess                         : =
FAILURE
>           OP_LAYOUTGET should return NFS4_OK, instead got
> 	              NFS4ERR_LAYOUTUNAVAILABLE
>=20
> They're probably easy fixes, but I'd rather leave them up to somebody
> that can test the result.  Patches on top of these would be best.
>=20


I=E2=80=99ll do that - but note that they were failing before my patch =
set.


> --b.
>=20
>>=20
>> FFST1    st_flex.testStateid1                                     : =
PASS
>> FFLA1    st_flex.testFlexLayoutTestAccess                         : =
FAILURE
>>           Expected uid_rd !=3D b'17', got b'17'
>> FFLG2    st_flex.testFlexLayoutStress                             : =
FAILURE
>>           TypeError: can only concatenate str (not "bytes") to
>>           str
>> FFLS3    st_flex.testFlexLayoutStatsStraight                      : =
FAILURE
>>           TypeError: can only concatenate str (not "bytes") to
>>           str
>> FFLS1    st_flex.testFlexLayoutStatsSmall                         : =
FAILURE
>>           TypeError: can't concat str to bytes
>> FFLS2    st_flex.testFlexLayoutStatsReset                         : =
FAILURE
>>           TypeError: can only concatenate str (not "bytes") to
>>           str
>> FFLS4    st_flex.testFlexLayoutStatsOverflow                      : =
FAILURE
>>           TypeError: can only concatenate str (not "bytes") to
>>           str
>> FFLORSTALEWRITE st_flex.testFlexLayoutReturnStaleWrite            : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_STALE, instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORSTALEREAD st_flex.testFlexLayoutReturnStaleRead              : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFLORSERVERFAULTWRITE st_flex.testFlexLayoutReturnServerFaultWrite : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_SERVERFAULT, instead got
>>           NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORSERVERFAULTREAD st_flex.testFlexLayoutReturnServerFaultRead  : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFLORNXIOWRITE st_flex.testFlexLayoutReturnNxioWrite              : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_NXIO, instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORNXIOREAD st_flex.testFlexLayoutReturnNxioRead                : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFLORNOSPCWRITE st_flex.testFlexLayoutReturnNospcWrite            : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_NOSPC, instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORNOSPC st_flex.testFlexLayoutReturnNospcRead                  : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORIOWRITE st_flex.testFlexLayoutReturnIoWrite                  : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_IO, instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORIOREAD st_flex.testFlexLayoutReturnIoRead                    : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFLORFBIGWRITE st_flex.testFlexLayoutReturnFbigWrite              : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_FBIG, instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORFBIG st_flex.testFlexLayoutReturnFbigRead                    : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORDELAYWRITE st_flex.testFlexLayoutReturnDelayWrite            : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY,
>>           instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORDELAYREAD st_flex.testFlexLayoutReturnDelayRead              : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFLORACCESSWRITE st_flex.testFlexLayoutReturnAccessWrite          : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>           NFS4ERR_ACCESS, instead got NFS4ERR_LAYOUTUNAVAILABLE
>> FFLORACCESSREAD st_flex.testFlexLayoutReturnAccessRead            : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFLOR100 st_flex.testFlexLayoutReturn100                          : =
FAILURE
>>           NameError: name 'xrange' is not defined
>> FFLOOS   st_flex.testFlexLayoutOldSeqid                           : =
FAILURE
>>           TypeError: can only concatenate str (not "bytes") to
>>           str
>> FFGLO1   st_flex.testFlexGetLayout                                : =
FAILURE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>           NFS4ERR_LAYOUTTRYLATER
>> FFGDI1   st_flex.testFlexGetDevInfo                               : =
FAILURE
>>           TypeError: can only concatenate str (not "bytes") to
>>           str
>>=20
>>=20
>> Regards,
>>   Tigran.
>>=20
>>=20
>>=20
>> ----- Original Message -----
>>> From: "J. Bruce Fields" <bfields@fieldses.org>
>>> To: "Tom Haynes" <loghyr@gmail.com>
>>> Cc: "bfields" <bfields@redhat.com>, "linux-nfs" =
<linux-nfs@vger.kernel.org>
>>> Sent: Friday, 18 December, 2020 15:46:05
>>> Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
>>=20
>>> On Wed, Dec 16, 2020 at 04:35:06PM -0800, Tom Haynes wrote:
>>>> Hi Bruce,
>>>>=20
>>>> Here are a series of patches that Hamerspace has applied to the
>>>> flex files testing.
>>>=20
>>> Thanks, applying.
>>>=20
>>> I'm pretty hands-off when it comes to pynfs tests I don't personally
>>> run.  If they work for you then I'm probably fine with them....
>>>=20
>>> --b.
>>>=20
>>>>=20
>>>> Thanks,
>>>> Tom
>>>>=20
>>>> Jean Spector (2):
>>>>  st_flex.py - Added tests for LAYOUTRETURN with errors
>>>>  st_flex.py - Fixed flag names
>>>>=20
>>>> Tom Haynes (7):
>>>>  Close the file for SEQ10b
>>>>  flexfiles: Fix up the layout error handling to reflect the =
previous
>>>>    error
>>>>  st_flex: Reduce the layoutstats period to make tests finish in a =
sane
>>>>    time
>>>>  st_flex: Fix up test names
>>>>  st_flex: Only do 100 layoutget/return in loop
>>>>  st_flex: We can't return the layout without a layout stateid
>>>>  st_flex: Fixup check for error in layoutget_return()
>>>>=20
>>>> Trond Myklebust (1):
>>>>  Fix testFlexLayoutOldSeqid
>>>>=20
>>>> nfs4.1/server41tests/st_flex.py     | 651 =
+++++++++++++++++++++++++---
>>>> nfs4.1/server41tests/st_sequence.py |   5 +
>>>> 2 files changed, 588 insertions(+), 68 deletions(-)
>>>>=20
>>>> --
>>>> 2.26.2

