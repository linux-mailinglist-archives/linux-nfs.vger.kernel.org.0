Return-Path: <linux-nfs+bounces-20262-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI4uLgvuuml0dAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20262-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 19:25:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D12E2C136E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435F83286D94
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A23AE1B1;
	Wed, 18 Mar 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvEln0u9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A63AD505;
	Wed, 18 Mar 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856628; cv=none; b=NiPKIepbLgOuOQ/XkTX+eJQw38yB3M89HCAkqTpZ+n1Y8LKo/Ml7WXPfnBZE9kFNkQBqr4WgFwu5ZzC3OxdSUMfRu/UxAkBAOJWIqSLEfqoZkbf+CXfpcvUlHJYiSCztucC9vhSSBYN/7r+rSg2ZOAtjKJrd6WkATfN3royG8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856628; c=relaxed/simple;
	bh=F3+nGxnlDv+cnJsGX0IaoR3M8nq/7SUgCnmNDxyi2mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtqNswJNPkkXQU7MFSVPrJaYIzJGC40vCZ5B0tj+myLHrApyQVriBFweVsBOm+8J23X9OUmnXVbrVGkhNJ0GveLIo22vkN8Wp2rv/I8fF1qSuNEOdLZ2Mk8CSRQo0sx5OITwkeftvOA0R0v0q7MeRv2TjQR9uwE1SrVHYxBrTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvEln0u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEBC2BCB1;
	Wed, 18 Mar 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773856628;
	bh=F3+nGxnlDv+cnJsGX0IaoR3M8nq/7SUgCnmNDxyi2mY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cvEln0u9RnqpRDf/RquyUKIFPgRrhOshLmIzmRqNS/8wcKn8KDkgPDdja8KU4YoXm
	 xtp0SNbK5XEj9D2PEdtpXuaaWDJfhSeH6btik+zpPgpktcHVLUCOYKdMYD+Ayj0Fs4
	 Cw8fNYquwBQagVECw9Y95EOHeb2dCzIH8zmFynyJJnTZ/YNj7FRDQTXokv4SN5k0Hg
	 KQUddAzZsefUIkzUCyzmQ3rWIeJRkgfObfj9b/HzZYHBD7yQQrBphHDErfqTOby/Ks
	 zbXQBQFX/GeClRiz8zinQj0hdBYskRF4qhEDh3jizxQxQgPbugknE/rcNbl5HiJKap
	 VLRmwrN9TRE3w==
Message-ID: <2ef59bf1-c4f7-4818-9f47-16d056edcb8b@kernel.org>
Date: Wed, 18 Mar 2026 13:57:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] NFSD: Add export-scoped state revocation
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
 <20260318-umount-kills-nfsv4-state-v4-5-56aad44ab982@oracle.com>
 <f582806fcf3c6d6f7416c24c55462fc502cb0ab0.camel@kernel.org>
 <202c9697-82cd-409a-8c5c-ea56a3830a8a@kernel.org>
 <c42d3896eb47aa3bb766f29776fd0aac2a1eb07d.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <c42d3896eb47aa3bb766f29776fd0aac2a1eb07d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20262-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3D12E2C136E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 10:58 AM, Jeff Layton wrote:
> On Wed, 2026-03-18 at 10:51 -0400, Chuck Lever wrote:
>> On 3/18/26 10:47 AM, Jeff Layton wrote:
>>> On Wed, 2026-03-18 at 10:15 -0400, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> nfsd4_revoke_states() revokes all NFSv4 state on an entire
>>>> superblock, which is too coarse when multiple exports share a
>>>> filesystem. Add nfsd4_revoke_export_states() to revoke only
>>>> state associated with files under a specific export root, then
>>>> convert nfsd4_revoke_states() to a thin wrapper that passes
>>>> sb->s_root.
>>>>
>>>> nfsd4_revoke_export_states() uses find_next_sb_stid() to locate
>>>> candidate stids, then verifies each against the export root via
>>>> nfsd_file_inode_is_in_subtree(). That helper is placed in the
>>>> file cache layer (filecache.c) because it operates on VFS types
>>>> with no NFSv4 state dependency. It walks all of an inode's
>>>> dentry aliases rather than calling d_find_any_alias(), because
>>>> for hard-linked files an arbitrary alias may fall outside the
>>>> export subtree even when another alias is inside it.
>>>>
>>>> When the export root is the filesystem root, the subtree check
>>>> is elided and every stid matching the superblock is revoked
>>>> directly.
>>>>
>>>> The NFSD_UNLOCK_TYPE_FILESYSTEM handler now calls
>>>> nfsd4_revoke_export_states() with the resolved path dentry,
>>>> enabling subtree-scoped revocation through the netlink
>>>> interface.
>>>>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/filecache.c | 32 +++++++++++++++++++
>>>>  fs/nfsd/filecache.h |  1 +
>>>>  fs/nfsd/nfs4state.c | 92 +++++++++++++++++++++++++++++++++++++----------------
>>>>  fs/nfsd/nfsctl.c    |  3 +-
>>>>  fs/nfsd/state.h     |  7 ++++
>>>>  5 files changed, 107 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index 1e2b38ed1d35..cd09be0c5465 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -894,6 +894,38 @@ __nfsd_file_cache_purge(struct net *net)
>>>>  	nfsd_file_dispose_list(&dispose);
>>>>  }
>>>>  
>>>> +/**
>>>> + * nfsd_file_inode_is_in_subtree - check whether an inode is under a subtree
>>>> + * @inode:        inode to test
>>>> + * @root_dentry:  dentry of the subtree root
>>>> + *
>>>> + * Check whether @inode has any dentry alias that falls within the
>>>> + * subtree rooted at @root_dentry.  Hard-linked files can have aliases
>>>> + * in multiple directories, so all aliases must be tested.
>>>> + *
>>>> + * Return: %true if any dentry alias of @inode is at or below
>>>> + * @root_dentry, %false otherwise.
>>>> + */
>>>> +bool nfsd_file_inode_is_in_subtree(struct inode *inode,
>>>> +				   struct dentry *root_dentry)
>>>> +{
>>>> +	struct dentry *alias;
>>>> +	bool found = false;
>>>> +
>>>> +	/* i_lock stabilizes the alias list; is_subdir() nests
>>>> +	 * rename_lock (a seqlock) beneath it but does not sleep.
>>>> +	 */
>>>> +	spin_lock(&inode->i_lock);
>>>> +	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
>>>> +		if (is_subdir(alias, root_dentry)) {
>>>> +			found = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +	spin_unlock(&inode->i_lock);
>>>> +	return found;
>>>> +}
>>>> +
>>>>  static struct nfsd_fcache_disposal *
>>>>  nfsd_alloc_fcache_disposal(void)
>>>>  {
>>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>>> index b383dbc5b921..36c9a8e388d2 100644
>>>> --- a/fs/nfsd/filecache.h
>>>> +++ b/fs/nfsd/filecache.h
>>>> @@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
>>>>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>>>>  struct file *nfsd_file_file(struct nfsd_file *nf);
>>>>  void nfsd_file_close_inode_sync(struct inode *inode);
>>>> +bool nfsd_file_inode_is_in_subtree(struct inode *inode, struct dentry *root_dentry);
>>>>  void nfsd_file_net_dispose(struct nfsd_net *nn);
>>>>  bool nfsd_file_is_cached(struct inode *inode);
>>>>  __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 891669b32804..581f38395c42 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -1763,15 +1763,6 @@ static struct nfs4_stid *find_next_sb_stid(struct nfs4_client *clp,
>>>>  	return stid;
>>>>  }
>>>>  
>>>> -static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
>>>> -					  struct super_block *sb,
>>>> -					  unsigned int sc_types)
>>>> -{
>>>> -	unsigned long id = 0;
>>>> -
>>>> -	return find_next_sb_stid(clp, sb, sc_types, &id);
>>>> -}
>>>> -
>>>>  static void revoke_ol_stid(struct nfs4_client *clp,
>>>>  			   struct nfs4_ol_stateid *stp)
>>>>  {
>>>> @@ -1835,20 +1826,19 @@ static void revoke_one_stid(struct nfs4_client *clp, struct nfs4_stid *stid)
>>>>  }
>>>>  
>>>>  /**
>>>> - * nfsd4_revoke_states - revoke all nfsv4 states associated with given filesystem
>>>> - * @nn:   used to identify instance of nfsd (there is one per net namespace)
>>>> - * @sb:   super_block used to identify target filesystem
>>>> + * nfsd4_revoke_export_states - revoke states associated with a given export
>>>> + * @nn:           nfsd_net identifying the nfsd instance (one per net namespace)
>>>> + * @sb:           super_block of the export's filesystem
>>>> + * @root_dentry:  dentry of the export root directory
>>>>   *
>>>>   * All nfs4 states (open, lock, delegation, layout) held by the server instance
>>>> - * and associated with a file on the given filesystem will be revoked resulting
>>>> - * in any files being closed and so all references from nfsd to the filesystem
>>>> - * being released.  Thus nfsd will no longer prevent the filesystem from being
>>>> - * unmounted.
>>>> - *
>>>> - * The clients which own the states will subsequently being notified that the
>>>> - * states have been "admin-revoked".
>>>> + * and associated with files under the given export will be revoked.  When
>>>> + * @root_dentry is the filesystem root, all state on @sb is revoked (equivalent
>>>> + * to nfsd4_revoke_states).  When @root_dentry is a subdirectory, only state on
>>>> + * files within that subtree is revoked.
>>>>   */
>>>> -void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
>>>> +void nfsd4_revoke_export_states(struct nfsd_net *nn, struct super_block *sb,
>>>> +				struct dentry *root_dentry)
>>>>  {
>>>>  	unsigned int idhashval;
>>>>  	unsigned int sc_types;
>>>> @@ -1861,18 +1851,53 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
>>>>  		struct nfs4_client *clp;
>>>>  	retry:
>>>>  		list_for_each_entry(clp, head, cl_idhash) {
>>>> -			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
>>>> -								  sc_types);
>>>> -			if (stid) {
>>>> -				spin_unlock(&nn->client_lock);
>>>> +			struct nfs4_stid *stid;
>>>> +			/* Resets to zero on each retry; revocation may
>>>> +			 * alter the IDR, so a stale cursor is unsafe.
>>>> +			 */
>>>> +			unsigned long id = 0;
>>>> +
>>>> +			while ((stid = find_next_sb_stid(clp, sb,
>>>> +						sc_types, &id)) != NULL) {
>>>> +				if (root_dentry != sb->s_root) {
>>>> +					bool match;
>>>> +
>>>> +					/* Bare inc to pin clp; get_client_locked() is
>>>> +					 * not used because its courtesy-to-active
>>>> +					 * transition is unwanted during revocation.
>>>> +					 */
>>>> +					atomic_inc(&clp->cl_rpc_users);
>>>> +					spin_unlock(&nn->client_lock);
>>>> +					match = nfsd_file_inode_is_in_subtree(
>>>> +							stid->sc_file->fi_inode,
>>>> +							root_dentry);
>>>
>>> Ouch the hardlinked thing makes this hard to reason about.
>>>
>>> Ok, so suppose we have two exports on the same superblock.
>>>
>>> /export/foo
>>> /export/bar
>>>
>>> One is exported to one client foo and one to another to client bar.
>>> There is a file hardlinked across those directories:
>>>
>>> $ touch /export/foo/baz
>>> $ ln /export/bar/baz /export/foo/baz
>>>
>>> Now, client foo opens /export/foo/baz, and client bar opens
>>> /export/bar/baz.
>>>
>>> /export/bar is unexported and state under it revoked. Won't client
>>> foo's state end up being revoked too in that case?
>>>
>>> Note that the different hardlinks should end up with different
>>> filehandles since they are exposed to the clients via different
>>> exports.
>>>
>>> I wonder... do we need keep track of the export under which a stateid
>>> was acquired so we can properly revoke the right ones in this
>>> situation?
>>
>> If I understand your comment correctly, I believe that is what the
>> earlier patches in this series do -- tie the state IDs to a particular
>> export.
>>
>>
> 
> I don't think so, not AFAICT. 
> 
> + * Check whether @inode has any dentry alias that falls within the
> + * subtree rooted at @root_dentry.  Hard-linked files can have aliases
> + * in multiple directories, so all aliases must be tested.
> 
> In this case, you're calling nfsd_file_inode_is_in_subtree(). In the
> above example, that's going to return true for foo's state, even though
> bar's export is the one being revoked.
> 
> I think to do this properly, you'd have to track an st_export field in
> struct nfs4_ol_stateid (or maybe in struct nfs4_stid).
> 
> OTOH, hardlinks are rare so maybe this isn't worth fretting over.

Probably rare, but the point is the current approach is difficult to
reason about, thus will be hard to maintain. For v5, I'll try linking
NFSv4 state to exports.


-- 
Chuck Lever

