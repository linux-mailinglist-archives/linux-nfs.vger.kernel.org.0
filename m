Return-Path: <linux-nfs+bounces-23165-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N1CWIZsmTmqvEAIAu9opvQ
	(envelope-from <linux-nfs+bounces-23165-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 12:29:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F641724561
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 12:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=medichon.fr header.s=ovhmo3801317-selector1 header.b=iytSqUQe;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23165-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23165-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55E2E30418CE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCCF393DE2;
	Wed,  8 Jul 2026 10:25:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from 10.mo583.mail-out.ovh.net (10.mo583.mail-out.ovh.net [46.105.52.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152538B123
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 10:25:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506309; cv=none; b=B/aK+HtGmUTpJl9q5ffU9kWKNxUuwZCxSxg8b8PZ5iK18eJAZMXeDkp4GPmR0muD1VrEyHBYC4kJML8hqSBLx4WuM1EU9qknLTyUTAy/5MTE5KWx9a4h4PZS2H9qFzmavWdyoIWFmajpJZ7LZNxj1mRKUIR/LxLurjNg5JStRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506309; c=relaxed/simple;
	bh=dW7OSHCzG1qwuJbRrmNmcKJKRL5nRxtrA4aPaDMNXqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4kd8+XuoAWok4fw3x94fcmu/5vgH9cD7Viyt2+q+GrxPAoe52gF9zT5Fau4PsjCdULPU312t6gQboieaYqHT/b5n/szW4SYVbug1QO+DITPf25x1pbGunlEh+bQFUkEWI6oePg8fffUvJrjnCo0X9Do11csTXACmrTyQXp4MO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr; spf=pass smtp.mailfrom=medichon.fr; dkim=pass (2048-bit key) header.d=medichon.fr header.i=@medichon.fr header.b=iytSqUQe; arc=none smtp.client-ip=46.105.52.148
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.249.167])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4gwCrt621Sz60Fs
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 09:45:50 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-hgqg5 (unknown [10.110.118.183])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 372A4811BE;
	Wed,  8 Jul 2026 09:45:50 +0000 (UTC)
Received: from medichon.fr ([37.59.142.100])
	by ghost-submission-7d8d68f679-hgqg5 with ESMTPSA
	id L3KLOE0cTmp/ZhwAv+Jrmg
	(envelope-from <abo@medichon.fr>); Wed, 08 Jul 2026 09:45:50 +0000
X-OVh-ClientIp:88.190.90.129
Message-ID: <db0c2094-fcaa-40b3-b570-135eaf5f2748@medichon.fr>
Date: Wed, 8 Jul 2026 11:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs: refactor pNFS functions using
 clear_and_wake_up_bit
To: Agatha Isabelle Moreira <code@agatha.dev>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com, jkoolstra@xs4all.nl
References: <cover.1782148639.git.abo@medichon.fr>
 <929ff54c0c212b22620d10e6d8bef2a01bc6fa30.1782148639.git.abo@medichon.fr>
 <guidai72It.44047.2026203akgZf5M7751Q5ElH_20715_LINUXKERNEL_AGATHA_@links.agatha.dev>
Content-Language: en-US, fr
From: Arnaud Bonnet <abo@medichon.fr>
In-Reply-To: <guidai72It.44047.2026203akgZf5M7751Q5ElH_20715_LINUXKERNEL_AGATHA_@links.agatha.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 2039567681600904913
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFeNOJbuVWMjZ4VKj3eoaRkPV2biCM8/+1PuX7bGee87H2IF9fF80Bqzcd1r9I2vMOKvzgKInoEAvonCzKH/wiPv2azrcRPURo5GGHNCw9GU61kksKqEfjBvKdGPgWC8H1/4QB6PzG3ntDeKOTjnQhfmGlLFwkWqOJJvxu5Xo1cK2IS97vvYiL6t/r+BttaYr6KxxfGP4G/CO9ajbvndlur4BTSEBotZ2ZclnAT9UifHmsIQ84yAZWd5iv2jp8B3/2XL2T5VHpq+a0UaNXfwMAM9sUyFnoVUyO/+tlATnUxzYjX0RbxiRaXlspMPGFRfV+lUQxw6kiu1OmYsyjtFb35ZbmfTxEoox3LZgu8vEr+VbZCfzR1VfLpm8yrYXOD/wtbCBWIMEG5GO5e+eDexMZnAl5tkh02YUlTVAY+60oHSCwxxuDqGc1g3nFUPiNFrD2fay4Fe2fgM0GgqWAb39bro1nF4u9+BAQgWnitSAgDwJ7VGTpIZ7lKFTcCJjvuOd6lHubuS4lrbU5kTGoVxlQXiQWdZL5Gvf9u6XXvAW5O4fqSf1y1+gpWFyTnGraLGff/lroHEAGPflorpNiMdpMpobnf//uHmX+Vjfu7uvIbSlSLeSJRPr49unlwlBXPuxErg6hNY28BaFWBAd95Tf4TSMfx+ByURBxcoBjUv2ISAQ
DKIM-Signature: a=rsa-sha256; bh=lbjM3y3QLFH2nVeZp7HINIV1Y9EsJuVo1RxlW6fLdW0=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1783503950; v=1;
 b=iytSqUQeg9po3/Jy0nwNpAu/6MLBYS4eQY8IUs2kSTlHvFXli6nVx2UlzevSxDNVTHrMeU8c
 kF4VFOQm/gzpaqQ4yx/lLdW3mGZEaUyZ+EYjJhd6/6B9bOcf3LvixWWMljKhmMb2vAforxM3vs/
 kzVrjddIlKBXW62XYmG50IV6TVxEeOQZIWVJJEDRKlznoaX0zUILfIt3HQAaWITGIFGPjRyL/1+
 E5QCvO7aDPYIL/2xjc5xE9dSezxE7Hrzi1W+M5hOVWu+xMQpK8r0wIBNUOIlrzMxb9KiKD3g5cl
 n1l0/f+Zc3jkWBNM5YwfLiMEHhAMv6IpXGAvncywSvm9g==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[medichon.fr:s=ovhmo3801317-selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,brighamcampbell.com,xs4all.nl];
	TAGGED_FROM(0.00)[bounces-23165-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:code@agatha.dev,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[medichon.fr];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[medichon.fr:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[abo@medichon.fr,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abo@medichon.fr,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,medichon.fr:from_mime,medichon.fr:email,medichon.fr:mid,medichon.fr:dkim,agatha.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F641724561

On 7/3/26 10:55 PM, Agatha Isabelle Moreira wrote:
> On Mon, Jun 22, 2026 at 07:55:11PM +0200, Arnaud Bonnet wrote:
>> Commit 8236b0ae31c83 ("bdi: wake up concurrent wb_shutdown() callers.")
>> introduces the clear_and_wake_up_bit() helper as a wrapper for the
>> common clear -> barrier -> wake up bitops sequence.
>>
>> The file pnfs.c has several helpers with identical contents. Thus they
>> are replaced with the more recent clean_and_wake_up_bit() global helper
>> which describes accurately its effects at the call and still specifies
>> the cleared bit. This also homogenizes the code with other subsystems.
>>
>> Since the helpers are no longer used after this, they can be safely
>> removed.
> 
> 
> Hi Arnaud!
> 
>>
>> Suggested-by: Agatha Isabelle Moreira <code@agatha.dev>
>> Link: https://kernelnewbies.org/Beginner%20Cleanup%20and%20Refactor%20Tasks%20by%20Agatha%20Isabelle%20Moreira#task_007
>> Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
>> ---
>>  fs/nfs/pnfs.c | 35 ++++++++++-------------------------
>>  1 file changed, 10 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
>> index 743467e9ba20..96ee18af1ebf 100644
>> --- a/fs/nfs/pnfs.c
>> +++ b/fs/nfs/pnfs.c
>> @@ -2100,15 +2100,6 @@ static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
>>  	return test_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
>>  }
>>  
>> -static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
>> -{
>> -	unsigned long *bitlock = &lo->plh_flags;
>> -
>> -	clear_bit_unlock(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
>> -	smp_mb__after_atomic();
>> -	wake_up_bit(bitlock, NFS_LAYOUT_FIRST_LAYOUTGET);
>> -}
> 
> I noticed that you found a subsystem function doing something quite
> similar to what the `clear_and_wake_up_bit()` function.
> 
> From the cleanup point of view it seems good to me, but I think some
> input from someone in the nfs subsystem would be highly appreciated to
> confirm the correctness of this refactor.
> 
> IDK if you considered or if this makes total sense, but my only concern
> here is that the maintainer *could* find the replaced function
> `pnfs_clear_first_layoutget()` preferable to be kept, since it carries
> some subsystem semantics (the `struct pnfs_layout_hdr *lo` argument and
> the NFS_LAYOUT_FIRST_LAYOUTGET bit). But I could also be completely
> wrong.
> 
> In the event that `NFS_LAYOUT_FIRST_LAYOUTGET` gets replaced by another
> constant in the future (IDK if this is a plausible possibility), by
> keeping the original function there would be only a single place to
> touch.
> 
> Let's hope this message attracts more comments from someone with the
> subsystem's expertise, which would be highly appreciated.

Hi Agatha, I agree this required consideration when doing the change,
however there is prior art with the use of clear_and_wake_up_bit and it
is pretty universally done as an open coded call. If this is not
desirable, I could resubmit (probably as a single patch) by only 
replacing the sequence in the helpers.

Some similar changes by Trond are f46f84931a0aa ("NFSv4/pNFS: Don't
call _nfs4_pnfs_v3_ds_connect multiple times") and 43d20e80e2880 ("NFS:
Fix a few more clear_bit() instances that need release semantics") and
these keep the helpers, although in those cases the functions do more
than just call clear_and_wake_up_bit.

Thanks for checking the patch!

>> -
>>  static void _add_to_server_list(struct pnfs_layout_hdr *lo,
>>  				struct nfs_server *server)
>>  {
>> @@ -2284,7 +2275,8 @@ pnfs_update_layout(struct inode *ino,
>>  					iomode, lo, lseg,
>>  					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
>>  			nfs4_schedule_stateid_recovery(server, ctx->state);
>> -			pnfs_clear_first_layoutget(lo);
>> +			clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
>> +				&lo->plh_flags);
>>  			pnfs_put_layout_hdr(lo);
>>  			goto lookup_again;
>>  		}
>> @@ -2353,7 +2345,8 @@ pnfs_update_layout(struct inode *ino,
>>  			if (!exception.retry)
>>  				goto out_put_layout_hdr;
>>  			if (first)
>> -				pnfs_clear_first_layoutget(lo);
>> +				clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
>> +					&lo->plh_flags);
>>  			trace_pnfs_update_layout(ino, pos, count,
>>  				iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
>>  			pnfs_put_layout_hdr(lo);
>> @@ -2365,7 +2358,7 @@ pnfs_update_layout(struct inode *ino,
>>  
>>  out_put_layout_hdr:
>>  	if (first)
>> -		pnfs_clear_first_layoutget(lo);
>> +		clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
>>  	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
>>  				 PNFS_UPDATE_LAYOUT_EXIT);
>>  	pnfs_put_layout_hdr(lo);
>> @@ -2457,7 +2450,7 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
>>  	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid, &rng,
>>  					     nfs_io_gfp_mask());
>>  	if (!lgp) {
>> -		pnfs_clear_first_layoutget(lo);
>> +		clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
>>  		nfs_layoutget_end(lo);
>>  		pnfs_put_layout_hdr(lo);
>>  		return;
>> @@ -2561,7 +2554,8 @@ void nfs4_lgopen_release(struct nfs4_layoutget *lgp)
>>  {
>>  	if (lgp != NULL) {
>>  		if (lgp->lo) {
>> -			pnfs_clear_first_layoutget(lgp->lo);
>> +			clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
>> +				&lgp->lo->plh_flags);
>>  			nfs_layoutget_end(lgp->lo);
>>  		}
>>  		pnfs_layoutget_free(lgp);
>> @@ -3273,15 +3267,6 @@ pnfs_generic_pg_readpages(struct nfs_pageio_descriptor *desc)
>>  }
>>  EXPORT_SYMBOL_GPL(pnfs_generic_pg_readpages);
>>  
>> -static void pnfs_clear_layoutcommitting(struct inode *inode)
>> -{
>> -	unsigned long *bitlock = &NFS_I(inode)->flags;
>> -
>> -	clear_bit_unlock(NFS_INO_LAYOUTCOMMITTING, bitlock);
>> -	smp_mb__after_atomic();
>> -	wake_up_bit(bitlock, NFS_INO_LAYOUTCOMMITTING);
>> -}
>> -
>>  /*
>>   * There can be multiple RW segments.
>>   */
>> @@ -3306,7 +3291,7 @@ static void pnfs_list_write_lseg_done(struct inode *inode, struct list_head *lis
>>  		pnfs_put_lseg(lseg);
>>  	}
>>  
>> -	pnfs_clear_layoutcommitting(inode);
>> +	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, &NFS_I(inode)->flags);
>>  }
>>  
>>  void pnfs_set_lo_fail(struct pnfs_layout_segment *lseg)
>> @@ -3446,7 +3431,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
>>  	spin_unlock(&inode->i_lock);
>>  	kfree(data);
>>  clear_layoutcommitting:
>> -	pnfs_clear_layoutcommitting(inode);
>> +	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, &NFS_I(inode)->flags);
>>  	goto out;
>>  }
>>  EXPORT_SYMBOL_GPL(pnfs_layoutcommit_inode);
>> -- 
>> 2.53.0
>>
> 
> Other than that, both patches appear to successfuly apply and compile
> just fine.

