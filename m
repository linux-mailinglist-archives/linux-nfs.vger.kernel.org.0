Return-Path: <linux-nfs+bounces-10855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DAFA708FB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 19:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BC616C77C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 18:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528E13D531;
	Tue, 25 Mar 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdH709Rp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5F2628C
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927144; cv=none; b=bjqUzCb7tJZc5pJet2bCOXjCrYZenyiwn61iuTfq5nJtoaj9GuZWXRlHblOznzH2PrN6DSmf/Kh0jVsGHAAaKj3WvUFFeaaBhhjFiA3S4w0pQ5U5jjfa+MlVLg8AzJQJIGVISwpzVLMfeLI85uAN+ay1eFwym6xY/xq9kdy3CY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927144; c=relaxed/simple;
	bh=MtT7fcKCCQsduzGUxt5aSFmA1c+8D95sDUoEeN6D4sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFEwquMMZYc4ANbqp1IbLbyBuMcx6hoqxsARRNZu7E4K9z6H9upd4KQrElUSvdtkWdlYeI8KXKFp2IADI/FIPA2mIx3lTjX83YhRyvZsl63/CsiSFCNyPGEqKpW0igPvxx0ORW/Pw88f1ok0xV+cQebHlOx2Xy5zZw2Jn5WuZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdH709Rp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGaUiq005408
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JRGNWIigpwo+sVTPh8kbLoLbaa55z6ir5sOM8yRKY3U=; b=PdH709RpCdHTnlhj
	ECryn1k1Bv/1QtXMucGxqJuc36hCjEx3xeuvj7YZ4T2Gwq8w+U5/hFSSBlv2a52L
	d6gmQJvp4KojBcSrRxH/ZtY/eAxtN9n2uDQni+C7Ef4Bjkd4v43Krri2bf87aOcx
	h5KYoENe5XitjLlEx2JTo0XAZ/n6XwxiHeeKsbPruPzKxWtpLMGaVfHdKW/497Ga
	OjbiVaac8The1DYmWIBWZHkYvLGjgkG1DDmLv3AnxTqfFtTjQVsxTpzqdgxUjpnp
	vT+imEzfvuP+/B7ZpY7h0ZSx60hjxRWUO5fM6wCuePM9hhInaY/NeghwnNmZAnko
	k/kPag==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcyajgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:25:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so10062753a91.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 11:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927141; x=1743531941;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRGNWIigpwo+sVTPh8kbLoLbaa55z6ir5sOM8yRKY3U=;
        b=DCu9NOIIs3vAIwAlAqvXsswpRFPx9RGvIURgd9Cy0eSdXbX7354mffk9nVYzvUCCY1
         pHuwg9nRQaRfzVb+E5pqInN5aWF0WD4zwlgVTZQYthJ8qbVSm9vqPr6FeyP64MlWrkO8
         EaEqS6jpyKtGKayYJexvIwgBCdOHD/ZZcUTN2CFCqGYOEAG9PZ61QD4tsVWPJKD2M2aE
         1+QjvrcVNDju/i0cYXE7sMS+itskoGBG97Zgv8KG6PAAhb/epmPge9BUGrxdCw8sMFA0
         +NYYIQVsUxOUA4BDzRPNsHMcrhdi5lyy7OPAZ8x1zVtIYa2YrsFWTN59dkfdmkYJywQR
         I9tg==
X-Gm-Message-State: AOJu0Yyl1mMHlDRaB/nSdVmvRlRu3oimJijRuhKjIVecJa02a6Qt3UX9
	UV5RHKEUEZWe2/LtSc+9+N38XHc08IVXrZSP4xvXPC8iZbCVGDtMfqQq25qwb2yc8r4WG4jsgDk
	i0yZbhQW3FsmoPTR9PwvY5HMvVUcwg7NevxuU1VCaJAl3yhiqsdvPK2mfV+s=
X-Gm-Gg: ASbGnct101Mv0byEnI2OA9JHzBNYPY0hZpbBRwolHoiWJYVamxhveAJGXa1X1cqKKYF
	bC06EQfYBO8X2J48wbO9B1oO54VetFp0fxQRllCjI1Vogp9g4EVcAizaruEZ4VRqa9SgWDF6zGJ
	ua+BQVN96jHhSdFVSaIXuR4iWsX5tKByh16ffcBVW9Jxm9EmWtAOcLbyBj+mKkOtlf3KkoZtBph
	GOiqAmqwlww7KeuSi425adGlHORNFWMjuXdqDluOuGcyxm4A2GQf2+qwm0Xpr2r+m2puYNbEhnk
	EzV0mmp4/ycLmeh63yl/AWOcUb08WuuBE4Vuh4artA4W1Q3fwfKG
X-Received: by 2002:a17:90b:2707:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-3030fefe3e4mr28947995a91.29.1742927140306;
        Tue, 25 Mar 2025 11:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKyThvP/6bv+vB1hA0BThsYJO6kjkY/GjavrCe9iZXGxCc0uzui9jC18dAshu5DJG0xEVGYw==
X-Received: by 2002:a17:90b:2707:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-3030fefe3e4mr28947947a91.29.1742927139718;
        Tue, 25 Mar 2025 11:25:39 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a682sm14705727a91.31.2025.03.25.11.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:25:39 -0700 (PDT)
Message-ID: <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 11:25:38 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs compile error nfslocalio.o and localio.o since v6.14-rc1
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali> <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250318190520.efwb45jarbyacnw4@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e2f525 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=0G27khmstMVWLXMTRScA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mb2HYd0p4foA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: D9Hbw0ya1Wm0A8lpHDjv-dWpXO9fkplH
X-Proofpoint-GUID: D9Hbw0ya1Wm0A8lpHDjv-dWpXO9fkplH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250126

On 3/18/25 12:05, Pali Rohár wrote:
> PING?
> 
> On Sunday 23 February 2025 19:27:46 Pali Rohár wrote:
>> Mike, have you looked at this issue?
>>
>> On Saturday 15 February 2025 17:51:00 Pali Rohár wrote:
>>> On Saturday 15 February 2025 11:41:25 Chuck Lever wrote:
>>>> On 2/15/25 11:38 AM, Pali Rohár wrote:
>>>>> On Saturday 15 February 2025 11:29:45 Chuck Lever wrote:
>>>>>> Hi Pali -
>>>>>>
>>>>>> On 2/15/25 7:00 AM, Pali Rohár wrote:
>>>>>>> Hello, since v6.14-rc1, file nfslocalio.c cannot be compiled with
>>>>>>> gcc-8.3 and attached .config file. Same problem is with localio.c.
>>>>>>
>>>>>> If the interwebs are correct, gcc-8.3 was released in 2014. ISTR that
>>>>>> recent releases of the Linux kernel no longer support gcc versions that
>>>>>> old.
>>>>>
>>>>> Hello, I know that this is old version, and I specially used it just to
>>>>> check if everything compiles correctly. And it failed.
>>>>>
>>>>> Per https://docs.kernel.org/process/changes.html the minimal version of
>>>>> gcc is 5.1, so I think that compilation with gcc 8.3 should still be
>>>>> supported.
>>>>>
>>>>>> It appears to be snagging on kernel-wide utility helpers, not code
>>>>>> specific to NFS.
>>>>>
>>>>> It looks like that, but only those two nfs files cause compile errors.
>>>>> Everything else compiles without problem. So it is quite suspicious and
>>>>> maybe it could signal that those helper are used incorrectly in nfs
>>>>> code? I'm not sure, I have not investigated it.
>>>>
>>>> A bisect would be helpful.
>>>>
>>>> Also, what is the CPU platform architecture? x86_64?
>>>
>>> Yes, it is x86_64, I hope that all details/configuration is in the
>>> .config file. I took generic gcc 8.3 version which was distributed by
>>> some debian version. So nothing special.
>>>
>>>>
>>>>>> If that's the case, it might not be possible for us to address this
>>>>>> breakage.
>>>>>>
>>>>>> Adding Mike, who contributed this code.
>>>>>>
>>>>>>> Error is:
>>>>>>>
>>>>>>> $ make bzImage
>>>>>>>   CALL    scripts/checksyscalls.sh
>>>>>>>   DESCEND objtool
>>>>>>>   INSTALL libsubcmd_headers
>>>>>>>   CC      fs/nfs_common/nfslocalio.o
>>>>>>> In file included from ./include/linux/rbtree.h:24,
>>>>>>>                  from ./include/linux/mm_types.h:11,
>>>>>>>                  from ./include/linux/mmzone.h:22,
>>>>>>>                  from ./include/linux/gfp.h:7,
>>>>>>>                  from ./include/linux/umh.h:4,
>>>>>>>                  from ./include/linux/kmod.h:9,
>>>>>>>                  from ./include/linux/module.h:17,
>>>>>>>                  from fs/nfs_common/nfslocalio.c:7:
>>>>>>> fs/nfs_common/nfslocalio.c: In function ‘nfs_close_local_fh’:
>>>>>>> ./include/linux/rcupdate.h:531:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
>>>>>>>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>>>>          ^
>>>>>>> ./include/linux/rcupdate.h:650:31: note: in expansion of macro ‘__rcu_access_pointer’
>>>>>>>  #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
>>>>>>>                                ^~~~~~~~~~~~~~~~~~~~
>>>>>>> fs/nfs_common/nfslocalio.c:288:10: note: in expansion of macro ‘rcu_access_pointer’
>>>>>>>   ro_nf = rcu_access_pointer(nfl->ro_file);
>>>>>>>           ^~~~~~~~~~~~~~~~~~
>>>>>>> make[4]: *** [scripts/Makefile.build:207: fs/nfs_common/nfslocalio.o] Error 1
>>>>>>> make[3]: *** [scripts/Makefile.build:465: fs/nfs_common] Error 2
>>>>>>> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
>>>>>>> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
>>>>>>> make: *** [Makefile:251: __sub-make] Error 2
>>>>>>>
>>>>>>>
>>>>>>> $ make fs/nfs/localio.o
>>>>>>>   CALL    scripts/checksyscalls.sh
>>>>>>>   DESCEND objtool
>>>>>>>   INSTALL libsubcmd_headers
>>>>>>>   CC      fs/nfs/localio.o
>>>>>>> In file included from ./include/linux/rbtree.h:24,
>>>>>>>                  from ./include/linux/mm_types.h:11,
>>>>>>>                  from ./include/linux/mmzone.h:22,
>>>>>>>                  from ./include/linux/gfp.h:7,
>>>>>>>                  from ./include/linux/umh.h:4,
>>>>>>>                  from ./include/linux/kmod.h:9,
>>>>>>>                  from ./include/linux/module.h:17,
>>>>>>>                  from fs/nfs/localio.c:11:
>>>>>>> fs/nfs/localio.c: In function ‘nfs_local_open_fh’:
>>>>>>> ./include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
>>>>>>>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>>>>          ^
>>>>>>> ./include/linux/rcupdate.h:686:2: note: in expansion of macro ‘__rcu_dereference_check’
>>>>>>>   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>>>>>>   ^~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> ./include/linux/rcupdate.h:758:28: note: in expansion of macro ‘rcu_dereference_check’
>>>>>>>  #define rcu_dereference(p) rcu_dereference_check(p, 0)
>>>>>>>                             ^~~~~~~~~~~~~~~~~~~~~
>>>>>>> fs/nfs/localio.c:275:7: note: in expansion of macro ‘rcu_dereference’
>>>>>>>   nf = rcu_dereference(*pnf);
>>>>>>>        ^~~~~~~~~~~~~~~
>>>>>>> make[4]: *** [scripts/Makefile.build:207: fs/nfs/localio.o] Error 1
>>>>>>> make[3]: *** [scripts/Makefile.build:465: fs/nfs] Error 2
>>>>>>> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
>>>>>>> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
>>>>>>> make: *** [Makefile:251: __sub-make] Error 2
>>>>>>>
>>>>>>>
>>>>>>> Reproduced from commit 7ff71e6d9239 ("Merge tag 'alpha-fixes-v6.14-rc2'
>>>>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha").

FWIW I'm seeing this issue using gcc-13.3.0-nolibc/x86_64-linux/bin/x86_64-linux-gcc
from https://www.kernel.org/pub/tools/crosstool so this isn't just a GCC version
issue. My workspace is based on 6.14-rc5

In file included from ./include/linux/rbtree.h:24,
                 from ./include/linux/mm_types.h:11,
                 from ./include/linux/mmzone.h:22,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/umh.h:4,
                 from ./include/linux/kmod.h:9,
                 from ./include/linux/module.h:17,
                 from fs/nfs/localio.c:11:
fs/nfs/localio.c: In function ‘nfs_local_open_fh’:
./include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
  538 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
      |         ^
./include/linux/rcupdate.h:686:2: note: in expansion of macro ‘__rcu_dereference_check’
  686 |  __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
      |  ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:758:28: note: in expansion of macro ‘rcu_dereference_check’
  758 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
      |                            ^~~~~~~~~~~~~~~~~~~~~
fs/nfs/localio.c:275:7: note: in expansion of macro ‘rcu_dereference’
  275 |  nf = rcu_dereference(*pnf);
      |       ^~~~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:207: fs/nfs/localio.o] Error 1

There is also a Intel kernel test robot report:
https://lore.kernel.org/all/202503181317.eiDzfsM0-lkp@intel.com/



