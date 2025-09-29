Return-Path: <linux-nfs+bounces-14795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7319BAAA0D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 23:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E3B16EADD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 21:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E71B87C0;
	Mon, 29 Sep 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxU0VNdF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2217996
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180573; cv=none; b=QzPGnlLcvMn+tVuNM8ismCik9YLuwI8gy9hzDV7WWWtqAcg2MaC/y/EkBuCSdxpuB+QinfHt/x4YWylEByEdoZptztXBoNBHnFgo2EqghkN/KNus1rRu2RMAoSe+ty5zsfG8WXUfNZb6WKW/g1Pq2Vutphk0strOttPbPyjcxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180573; c=relaxed/simple;
	bh=6+eZpl0/BhoqsCq2MpWNWIzS0Tvb9A5mek1zE6EHScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNQugwsY+UCZazmuoahp2djp5N8AcoyMlVy2/EnLVv+OpeGMzVmu/x9UrcNDjWc6q3MqcuSl5BCZtUlANg8eE9VTiDnA80P9vLrZv2JXZUnqfB2j+Rx9um01HaTS5v75D7jWWHu4bxG580p86AIuMi9yUhwmGZj4UnOcBVo3NBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxU0VNdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC5EC4CEF4;
	Mon, 29 Sep 2025 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759180571;
	bh=6+eZpl0/BhoqsCq2MpWNWIzS0Tvb9A5mek1zE6EHScY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NxU0VNdFQ+D0sKbWXAMm2Z1EnSEzLYbsReLMHU+s+u52fkloil4DSUWuGQsNKS1BM
	 lObXw3NrN5FZA7STtyaFZdlUrGT/uJAEMQCmf8J57uBH+1RLesGZmV2lVFvJcdXgkQ
	 GscpuTmE5L2b5g9rDVibsmwAhm1/+h90lVuPijw74oycZJrI0+SV37bKqRZvvE3sSD
	 bpYQKEy0mij1lq/0wbl2WrtcJeb9ha5BFb5SLMxm4AivrZ83dOVzxkKkbGy0akwkN0
	 XInRfo6ZphEarBVC9mGrHw+tbVtsdEQRqj7Z+O6gOMm3GHe7I0MWqBv/wfVwNW/oin
	 CBF1BSYaHr2JQ==
Message-ID: <f86efa58-3dec-42e9-b992-884fc143457d@kernel.org>
Date: Mon, 29 Sep 2025 17:16:10 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add some tests for unsupported fattr4 attributes
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250929201622.37884-1-cel@kernel.org>
 <d195b486-a351-4ff7-838e-47d97f9ac0a1@oracle.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <d195b486-a351-4ff7-838e-47d97f9ac0a1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/29/25 2:14 PM, Calum Mackay wrote:
> thanks Chuck,
> 
> I'm still catching up with pynfs patches; I'll get this (and the others
> queued up) in asap.

My patch deserves a smell test first, of course. I'm not at all sure
this is reasonable or proper Python.


> cheers,
> c.
> 
> 
> On 29/09/2025 9:16 pm, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Linux NFSD does not implement a handful of these NFSv4.0 fattr4
>> attributes. Ensure that NFSD's fattr4 result encoder is correctly
>> clearing the result mask and returning NFS4_OK.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   nfs4.0/servertests/st_getattr.py | 149 +++++++++++++++++++++++++++++++
>>   1 file changed, 149 insertions(+)
>>
>> diff --git a/nfs4.0/servertests/st_getattr.py b/nfs4.0/servertests/
>> st_getattr.py
>> index 1c47ebf60571..d423aa1df46d 100644
>> --- a/nfs4.0/servertests/st_getattr.py
>> +++ b/nfs4.0/servertests/st_getattr.py
>> @@ -521,6 +521,155 @@ def testOwnerName(t, env):
>>           t.fail_support("owner not a supported attribute")
>>       # print(res.resarray[-1].obj_attributes)
>>   +def testArchive(t, env):
>> +    """GETATTR on "archive" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11a
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_ARCHIVE])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(archive)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("archive not a supported attribute")
>> +
>> +def testHidden(t, env):
>> +    """GETATTR on "hidden" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11b
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_HIDDEN])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(hidden)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("hidden not a supported attribute")
>> +
>> +def testMimetype(t, env):
>> +    """GETATTR on "mimetype" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11c
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_MIMETYPE])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(mimetype)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("mimetype not a supported attribute")
>> +
>> +def testQuotaAvailHard(t, env):
>> +    """GETATTR on "quota avail hard" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11d
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_QUOTA_AVAIL_HARD])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP],
>> "GETATTR(quota_avail_hard)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("quota_avail_hard not a supported attribute")
>> +
>> +def testQuotaAvailSoft(t, env):
>> +    """GETATTR on "quota avail soft" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11e
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_QUOTA_AVAIL_SOFT])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP],
>> "GETATTR(quota_avail_soft)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("quota_avail_soft not a supported attribute")
>> +
>> +def testQuotaUsed(t, env):
>> +    """GETATTR on "quota used" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11f
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_QUOTA_USED])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_used)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("quota_used not a supported attribute")
>> +
>> +def testSystem(t, env):
>> +    """GETATTR on "system" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11g
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_SYSTEM])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(system)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("system not a supported attribute")
>> +
>> +def testTimeBackup(t, env):
>> +    """GETATTR on "time backup" attribute
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11h
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_TIME_BACKUP])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_backup)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("time_backup not a supported attribute")
>> +
>> +def testTimeAccessSet(t, env):
>> +    """GETATTR on "time access set" attribute (write-only)
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11i
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_TIME_ACCESS_SET])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP],
>> "GETATTR(time_access_set)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("time_access_set not a supported attribute")
>> +
>> +def testTimeModifySet(t, env):
>> +    """GETATTR on "time modify set" attribute (write-only)
>> +
>> +    FLAGS: getattr all
>> +    DEPEND: LOOKFILE
>> +    CODE: GATT11j
>> +    """
>> +    c = env.c1
>> +    ops = c.use_obj(env.opts.usefile)
>> +    ops += [c.getattr([FATTR4_TIME_MODIFY_SET])]
>> +    res = c.compound(ops)
>> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP],
>> "GETATTR(time_modify_set)")
>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>> +        t.fail_support("time_modify_set not a supported attribute")
>>     ####################################################
>>   
> 


-- 
Chuck Lever

