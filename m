Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7A2DE7A2
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Dec 2020 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgLRQvB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Dec 2020 11:51:01 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:43944 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgLRQvA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 18 Dec 2020 11:51:00 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 002501610CE
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 17:50:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 002501610CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1608310217; bh=wzBSDcbk5EfYtRIJBDIHnvCHyJPZHCfXtdC4XaxiLLU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=heSriplGg1Gb1RphR6/5mhVAGrSpwl3HWcRVE3yY5JBac2DIVor5O2nol2ZSFahXZ
         1zLHU23psf8MaAQCiDSHdDOJ/8yAyb7JG++xOEyOtZdHBldFaHvFeKAYXkIJxIclZ3
         fFA2i+w2PbUfC0QfpU4MUM5mZITqT2NfVk715n3U=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id EB9691A0089;
        Fri, 18 Dec 2020 17:50:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id C140C1001A7;
        Fri, 18 Dec 2020 17:50:16 +0100 (CET)
Date:   Fri, 18 Dec 2020 17:50:16 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Tom Haynes <loghyr@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        bfields <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <390162557.5382045.1608310216661.JavaMail.zimbra@desy.de>
In-Reply-To: <129D549F-66DC-43FE-B303-042442CDAAC8@gmail.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com> <20201218144605.GB1258@fieldses.org> <1510952492.5375434.1608308638350.JavaMail.zimbra@desy.de> <20201218163721.GC1258@fieldses.org> <129D549F-66DC-43FE-B303-042442CDAAC8@gmail.com>
Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Misc Fixes, primarily LAYOUTRETURN
Thread-Index: Jm5PJtnVxZlYyEA2jfMwduPdCLAzBw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Let correct myself: some of them fail due to python3.

Tigran.

----- Original Message -----
> From: "Tom Haynes" <loghyr@gmail.com>
> To: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "bfields" <bfields@red=
hat.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Friday, 18 December, 2020 17:38:54
> Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN

>> On Dec 18, 2020, at 8:37 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>>=20
>> On Fri, Dec 18, 2020 at 05:23:58PM +0100, Mkrtchyan, Tigran wrote:
>>>=20
>>> I run the tests. They fail due to python3 incompatibility:
>>=20
>> Thanks!  I can't reproduce these, I assume because they're failing too
>> early?:
>>=20
>> FFLA1    st_flex.testFlexLayoutTestAccess                         : RUNN=
ING
>> FFLA1    st_flex.testFlexLayoutTestAccess                         : FAIL=
URE
>>           OP_LAYOUTGET should return NFS4_OK, instead got
>> =09              NFS4ERR_LAYOUTUNAVAILABLE
>>=20
>> They're probably easy fixes, but I'd rather leave them up to somebody
>> that can test the result.  Patches on top of these would be best.
>>=20
>=20
>=20
> I=E2=80=99ll do that - but note that they were failing before my patch se=
t.
>=20
>=20
>> --b.
>>=20
>>>=20
>>> FFST1    st_flex.testStateid1                                     : PAS=
S
>>> FFLA1    st_flex.testFlexLayoutTestAccess                         : FAI=
LURE
>>>           Expected uid_rd !=3D b'17', got b'17'
>>> FFLG2    st_flex.testFlexLayoutStress                             : FAI=
LURE
>>>           TypeError: can only concatenate str (not "bytes") to
>>>           str
>>> FFLS3    st_flex.testFlexLayoutStatsStraight                      : FAI=
LURE
>>>           TypeError: can only concatenate str (not "bytes") to
>>>           str
>>> FFLS1    st_flex.testFlexLayoutStatsSmall                         : FAI=
LURE
>>>           TypeError: can't concat str to bytes
>>> FFLS2    st_flex.testFlexLayoutStatsReset                         : FAI=
LURE
>>>           TypeError: can only concatenate str (not "bytes") to
>>>           str
>>> FFLS4    st_flex.testFlexLayoutStatsOverflow                      : FAI=
LURE
>>>           TypeError: can only concatenate str (not "bytes") to
>>>           str
>>> FFLORSTALEWRITE st_flex.testFlexLayoutReturnStaleWrite            : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_STALE, instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORSTALEREAD st_flex.testFlexLayoutReturnStaleRead              : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFLORSERVERFAULTWRITE st_flex.testFlexLayoutReturnServerFaultWrite : FA=
ILURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_SERVERFAULT, instead got
>>>           NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORSERVERFAULTREAD st_flex.testFlexLayoutReturnServerFaultRead  : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFLORNXIOWRITE st_flex.testFlexLayoutReturnNxioWrite              : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_NXIO, instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORNXIOREAD st_flex.testFlexLayoutReturnNxioRead                : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFLORNOSPCWRITE st_flex.testFlexLayoutReturnNospcWrite            : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_NOSPC, instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORNOSPC st_flex.testFlexLayoutReturnNospcRead                  : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORIOWRITE st_flex.testFlexLayoutReturnIoWrite                  : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_IO, instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORIOREAD st_flex.testFlexLayoutReturnIoRead                    : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFLORFBIGWRITE st_flex.testFlexLayoutReturnFbigWrite              : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_FBIG, instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORFBIG st_flex.testFlexLayoutReturnFbigRead                    : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORDELAYWRITE st_flex.testFlexLayoutReturnDelayWrite            : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY,
>>>           instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORDELAYREAD st_flex.testFlexLayoutReturnDelayRead              : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFLORACCESSWRITE st_flex.testFlexLayoutReturnAccessWrite          : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>>>           NFS4ERR_ACCESS, instead got NFS4ERR_LAYOUTUNAVAILABLE
>>> FFLORACCESSREAD st_flex.testFlexLayoutReturnAccessRead            : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFLOR100 st_flex.testFlexLayoutReturn100                          : FAI=
LURE
>>>           NameError: name 'xrange' is not defined
>>> FFLOOS   st_flex.testFlexLayoutOldSeqid                           : FAI=
LURE
>>>           TypeError: can only concatenate str (not "bytes") to
>>>           str
>>> FFGLO1   st_flex.testFlexGetLayout                                : FAI=
LURE
>>>           OP_LAYOUTGET should return NFS4_OK, instead got
>>>           NFS4ERR_LAYOUTTRYLATER
>>> FFGDI1   st_flex.testFlexGetDevInfo                               : FAI=
LURE
>>>           TypeError: can only concatenate str (not "bytes") to
>>>           str
>>>=20
>>>=20
>>> Regards,
>>>   Tigran.
>>>=20
>>>=20
>>>=20
>>> ----- Original Message -----
>>>> From: "J. Bruce Fields" <bfields@fieldses.org>
>>>> To: "Tom Haynes" <loghyr@gmail.com>
>>>> Cc: "bfields" <bfields@redhat.com>, "linux-nfs" <linux-nfs@vger.kernel=
.org>
>>>> Sent: Friday, 18 December, 2020 15:46:05
>>>> Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
>>>=20
>>>> On Wed, Dec 16, 2020 at 04:35:06PM -0800, Tom Haynes wrote:
>>>>> Hi Bruce,
>>>>>=20
>>>>> Here are a series of patches that Hamerspace has applied to the
>>>>> flex files testing.
>>>>=20
>>>> Thanks, applying.
>>>>=20
>>>> I'm pretty hands-off when it comes to pynfs tests I don't personally
>>>> run.  If they work for you then I'm probably fine with them....
>>>>=20
>>>> --b.
>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>> Tom
>>>>>=20
>>>>> Jean Spector (2):
>>>>>  st_flex.py - Added tests for LAYOUTRETURN with errors
>>>>>  st_flex.py - Fixed flag names
>>>>>=20
>>>>> Tom Haynes (7):
>>>>>  Close the file for SEQ10b
>>>>>  flexfiles: Fix up the layout error handling to reflect the previous
>>>>>    error
>>>>>  st_flex: Reduce the layoutstats period to make tests finish in a san=
e
>>>>>    time
>>>>>  st_flex: Fix up test names
>>>>>  st_flex: Only do 100 layoutget/return in loop
>>>>>  st_flex: We can't return the layout without a layout stateid
>>>>>  st_flex: Fixup check for error in layoutget_return()
>>>>>=20
>>>>> Trond Myklebust (1):
>>>>>  Fix testFlexLayoutOldSeqid
>>>>>=20
>>>>> nfs4.1/server41tests/st_flex.py     | 651 +++++++++++++++++++++++++--=
-
>>>>> nfs4.1/server41tests/st_sequence.py |   5 +
>>>>> 2 files changed, 588 insertions(+), 68 deletions(-)
>>>>>=20
>>>>> --
> >>>> 2.26.2
