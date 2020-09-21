Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF527221E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 13:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIULRn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 07:17:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55734 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgIULRn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 07:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600687061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxJL+ai8jJjZk12MQVcqSy9Gkb96p8TvroAyy+FoyUU=;
        b=bFP+WTHIsp7LsV1MSKBPWWzp272dKhPZxvByHu4Wx9uffqon0V2TCVKbt1c5d9LLqsENW2
        lXzCF6Icucp4tTcyhWZgN4dL9sVmU56wsaRUwVsOQIeKDI0nCgiWIXqcLsfN7D32V4v7+0
        8Swx2SODQ8tIjcbPqHdTf24yIu5tWjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-iuUMhqgHOUahW8G51keFjw-1; Mon, 21 Sep 2020 07:17:39 -0400
X-MC-Unique: iuUMhqgHOUahW8G51keFjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D951005504;
        Mon, 21 Sep 2020 11:17:37 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FCF25D9D5;
        Mon, 21 Sep 2020 11:17:37 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] NFSv4: Refactor nfs_need_update_open_stateid()
Date:   Mon, 21 Sep 2020 07:17:36 -0400
Message-ID: <61369AD2-60E8-4B10-8AB5-DAA9BEAE257D@redhat.com>
In-Reply-To: <d6c4cd73c3546057edfe8d80512b274bb431d68e.1600686204.git.bcodding@redhat.com>
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <d6c4cd73c3546057edfe8d80512b274bb431d68e.1600686204.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NACK.  Please drop this patch..  This is a junk version of this patch 
that I was
using for debugging that I sent by mistake.  I'll send a cleaned up 
version separately.

Ben

On 21 Sep 2020, at 7:04, Benjamin Coddington wrote:

> The logic was becoming difficult to follow.  Add some comments and 
> local
> variables to clarify the behavior.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 9ced7a62c05e..499f978d48aa 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -1568,23 +1568,34 @@ static void 
> nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
>  static bool nfs_need_update_open_stateid(struct nfs4_state *state,
>  		const nfs4_stateid *stateid)
>  {
> -	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
> -	    !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
> -		if (stateid->seqid == cpu_to_be32(1)) {
> +	bool state_matches_other = nfs4_stateid_match_other(stateid, 
> &state->open_stateid);
> +	bool seqid_one = stateid->seqid == cpu_to_be32(1);
> +
> +	if (test_bit(NFS_OPEN_STATE, &state->flags)) {
> +		/* The common case - we're updating to a new sequence number */
> +		if (state_matches_other && nfs4_stateid_is_newer(stateid, 
> &state->open_stateid)) {
> +			nfs_state_log_out_of_order_open_stateid(state, stateid);
> +			return true;
> +		}
> +		/* We lost a race with a self-bumping close, do recovery */
> +		if (!state_matches_other) {
> +			trace_printk("lost race to self-bump close\n");
> +			return false;
> +		}
> +	} else {
> +		/* The common case, this is the first OPEN */
> +		if (!state_matches_other && seqid_one) {
>  			nfs_state_log_update_open_stateid(state);
> -		} else {
> -			if (!nfs4_stateid_match_other(stateid, &state->open_stateid))
> -				return false;
> -			else
> -				set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
> +			return true;
> +		}
> +		/* We lost a race either with a self-bumping close, OR with the 
> first OPEN */
> +		if (!state_matches_other && !seqid_one) {
> +			trace_printk("lost race to self-bump close OR first OPEN\n");
> +			set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
> +			return true;
>  		}
> -		return true;
> -	}
> -
> -	if (nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
> -		nfs_state_log_out_of_order_open_stateid(state, stateid);
> -		return true;
>  	}
> +	/* Should be impossible to reach: */
>  	return false;
>  }
>
> -- 
> 2.20.1

