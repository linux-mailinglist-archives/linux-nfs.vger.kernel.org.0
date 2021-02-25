Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998833255CF
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 19:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBYStl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 13:49:41 -0500
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:35168
        "EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233311AbhBYStf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 13:49:35 -0500
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2021 13:49:34 EST
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id FLXxlRxhQiRGaFLXylapkl; Thu, 25 Feb 2021 11:39:34 -0700
X-CMAE-Analysis: v=2.4 cv=V8a4bcri c=1 sm=1 tr=0 ts=6037eee6
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=mJjC6ScEAAAA:8 a=QrBhlZxuFiXFSL2-A4QA:9
 a=QEXdDO2ut3YA:10 a=ijnPKfduoCotzip5AuI1:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH] nfsd: don't abort copies early
To:     Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
References: <20210224183950.GB11591@fieldses.org>
 <20210224193135.GC11591@fieldses.org>
 <59A5F476-EE0C-454F-8365-3F16505D9D45@oracle.com>
 <20210224223349.GB25689@fieldses.org>
 <CDFF4F84-1A0C-4E4C-A18B-AC39F715E6D8@oracle.com>
 <CAN-5tyFLLLfMwZVFrnQaCnR36Rfq_hPsmLEOLG2Qtrpc+pT7fA@mail.gmail.com>
 <20210225155715.GD17634@fieldses.org>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <83f6cd8f-5a29-3dee-4359-6be01ab6d894@talpey.com>
Date:   Thu, 25 Feb 2021 13:39:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210225155715.GD17634@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO1OvEUOex4mhnlSJ6yMC3dCaP4SL9o2O5D7EaERKtx9X1P9igtrfo24k5KPusXlEALOfX6e4CqKuo44v8SJcCRmcbxbIupmNnmPtgkSHxpJNW7umgJf
 NNVmNfYd+FtJ39l72XapaidT5N27cMFEyra6YZBWaIMsDUTYr9TixE+gRnbeRhmpcY8Jo1788Z3tD9UBdWAWRers1orQHjxGTQrJ6S/aww92M82KvLHmGKkj
 h8w3zXPLekjwsxSsG09/TCrZ8AzUaNjztiPeI0g/pXaN4zPU9IwVepxwpv3ITatVP8k6/rYnkA6wBTyTGgJ0Ew==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/25/2021 10:57 AM, Bruce Fields wrote:
> On Thu, Feb 25, 2021 at 10:33:04AM -0500, Olga Kornievskaia wrote:
>> On Thu, Feb 25, 2021 at 10:30 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>> On Feb 24, 2021, at 5:33 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>>> On Wed, Feb 24, 2021 at 07:34:10PM +0000, Chuck Lever wrote:
>>>>>> On Feb 24, 2021, at 2:31 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>>>>>
>>>>>> I confess I always have to stare at these comparisons for a minute to
>>>>>> figure out which way they should go.  And the logic in each of these
>>>>>> loops is a little repetitive.
>>>>>>
>>>>>> Would it be worth creating a little state_expired() helper to work out
>>>>>> the comparison and the new timeout?
>>>>>
>>>>> That's better, but aren't there already operators on time64_t data objects
>>>>> that can be used for this?
>>>>
>>>> No idea.
>>>
>>> I was thinking of jiffies, I guess. time_before() and time_after().
>>
>> Just my 2c. My initial original patches used time_after(). It was
>> specifically changed by somebody later to use the current api.
> 
> Yes, that was part of some Y2038 project on Arnd Bergman's part:
> 
> 	20b7d86f29d3 nfsd: use boottime for lease expiry calculation
> 
> I think 64-bit time_t is good for something like a hundred billion
> years, so wraparound isn't an issue.

Well, the universe is somewhere below 14B so that's good, but is this
time guaranteed to be monotonic? If someone sets the system time, many
clocks can go backward...

Tom.

> I think the conversion was correct, so the bug was there from the start.
> 
> Easy mistake to make, and hard to hit in testing, because on an
> otherwise unoccupied server and fast network the laundromat probably
> won't run while your COPY is in progress.
> 
> --b.
> 
>>
>>> Checking the definition of time64_t, from include/linux/time64.h:
>>>
>>> typedef __s64 time64_t;
>>>
>>> Signed, hrm. And no comparison helpers.
>>>
>>> I might be a little concerned about wrapping time values. But any
>>> concerns can be addressed in the new common helper state_expired(),
>>> possibly as a subsequent patch.
>>>
>>> If you feel it's ready, can you send me the below clean-up as an
>>> official patch with description and SoB?
>>>
>>>
>>>> --b.
>>>>
>>>>>
>>>>>
>>>>>> --b.
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 61552e89bd89..00fb3603c29e 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
>>>>>>      return true;
>>>>>> }
>>>>>>
>>>>>> +struct laundry_time {
>>>>>> +   time64_t cutoff;
>>>>>> +   time64_t new_timeo;
>>>>>> +};
>>>>>> +
>>>>>> +bool state_expired(struct laundry_time *lt, time64_t last_refresh)
>>>>>> +{
>>>>>> +   time64_t time_remaining;
>>>>>> +
>>>>>> +   if (last_refresh > lt->cutoff)
>>>>>> +           return true;
>>>>>> +   time_remaining = lt->cutoff - last_refresh;
>>>>>> +   lt->new_timeo = min(lt->new_timeo, time_remaining);
>>>>>> +   return false;
>>>>>> +}
>>>>>> +
>>>>>> static time64_t
>>>>>> nfs4_laundromat(struct nfsd_net *nn)
>>>>>> {
>>>>>> @@ -5372,14 +5388,16 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>      struct nfs4_ol_stateid *stp;
>>>>>>      struct nfsd4_blocked_lock *nbl;
>>>>>>      struct list_head *pos, *next, reaplist;
>>>>>> -   time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;
>>>>>> -   time64_t t, new_timeo = nn->nfsd4_lease;
>>>>>> +   struct laundry_time lt = {
>>>>>> +           .cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
>>>>>> +           .new_timeo = nn->nfsd4_lease
>>>>>> +   };
>>>>>>      struct nfs4_cpntf_state *cps;
>>>>>>      copy_stateid_t *cps_t;
>>>>>>      int i;
>>>>>>
>>>>>>      if (clients_still_reclaiming(nn)) {
>>>>>> -           new_timeo = 0;
>>>>>> +           lt.new_timeo = 0;
>>>>>>              goto out;
>>>>>>      }
>>>>>>      nfsd4_end_grace(nn);
>>>>>> @@ -5389,7 +5407,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>      idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
>>>>>>              cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
>>>>>>              if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
>>>>>> -                           cps->cpntf_time < cutoff)
>>>>>> +                           state_expired(&lt, cps->cpntf_time))
>>>>>>                      _free_cpntf_state_locked(nn, cps);
>>>>>>      }
>>>>>>      spin_unlock(&nn->s2s_cp_lock);
>>>>>> @@ -5397,11 +5415,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>      spin_lock(&nn->client_lock);
>>>>>>      list_for_each_safe(pos, next, &nn->client_lru) {
>>>>>>              clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>>>> -           if (clp->cl_time > cutoff) {
>>>>>> -                   t = clp->cl_time - cutoff;
>>>>>> -                   new_timeo = min(new_timeo, t);
>>>>>> +           if (!state_expired(&lt, clp->cl_time))
>>>>>>                      break;
>>>>>> -           }
>>>>>>              if (mark_client_expired_locked(clp)) {
>>>>>>                      trace_nfsd_clid_expired(&clp->cl_clientid);
>>>>>>                      continue;
>>>>>> @@ -5418,11 +5433,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>      spin_lock(&state_lock);
>>>>>>      list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>>>>>              dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>>>>>> -           if (dp->dl_time > cutoff) {
>>>>>> -                   t = dp->dl_time - cutoff;
>>>>>> -                   new_timeo = min(new_timeo, t);
>>>>>> +           if (!state_expired(&lt, clp->cl_time))
>>>>>>                      break;
>>>>>> -           }
>>>>>>              WARN_ON(!unhash_delegation_locked(dp));
>>>>>>              list_add(&dp->dl_recall_lru, &reaplist);
>>>>>>      }
>>>>>> @@ -5438,11 +5450,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>      while (!list_empty(&nn->close_lru)) {
>>>>>>              oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
>>>>>>                                      oo_close_lru);
>>>>>> -           if (oo->oo_time > cutoff) {
>>>>>> -                   t = oo->oo_time - cutoff;
>>>>>> -                   new_timeo = min(new_timeo, t);
>>>>>> +           if (!state_expired(&lt, oo->oo_time))
>>>>>>                      break;
>>>>>> -           }
>>>>>>              list_del_init(&oo->oo_close_lru);
>>>>>>              stp = oo->oo_last_closed_stid;
>>>>>>              oo->oo_last_closed_stid = NULL;
>>>>>> @@ -5468,11 +5477,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>      while (!list_empty(&nn->blocked_locks_lru)) {
>>>>>>              nbl = list_first_entry(&nn->blocked_locks_lru,
>>>>>>                                      struct nfsd4_blocked_lock, nbl_lru);
>>>>>> -           if (nbl->nbl_time > cutoff) {
>>>>>> -                   t = nbl->nbl_time - cutoff;
>>>>>> -                   new_timeo = min(new_timeo, t);
>>>>>> +           if (!state_expired(&lt, oo->oo_time))
>>>>>>                      break;
>>>>>> -           }
>>>>>>              list_move(&nbl->nbl_lru, &reaplist);
>>>>>>              list_del_init(&nbl->nbl_list);
>>>>>>      }
>>>>>> @@ -5485,8 +5491,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>>>              free_blocked_lock(nbl);
>>>>>>      }
>>>>>> out:
>>>>>> -   new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>>>>> -   return new_timeo;
>>>>>> +   return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>>>>> }
>>>>>>
>>>>>> static struct workqueue_struct *laundry_wq;
>>>>>
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>>
>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
> 
