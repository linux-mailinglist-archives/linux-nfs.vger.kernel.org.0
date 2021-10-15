Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5142F5E3
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhJOOpR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 10:45:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55382 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbhJOOpR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Oct 2021 10:45:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:48230)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mbOQP-001lT2-P8; Fri, 15 Oct 2021 08:43:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36892 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mbOQO-007RxG-Qp; Fri, 15 Oct 2021 08:43:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Sargun Dhillon <sargun@sargun.me>
References: <20211014160230.106976-1-legion@kernel.org>
Date:   Fri, 15 Oct 2021 09:43:01 -0500
In-Reply-To: <20211014160230.106976-1-legion@kernel.org> (Alexey Gladkov's
        message of "Thu, 14 Oct 2021 18:02:30 +0200")
Message-ID: <87o87qxsay.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mbOQO-007RxG-Qp;;;mid=<87o87qxsay.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/IMy026dG3gJOeucUGJ4SAuwgKEo298OU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4965]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 335 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (1.3%), b_tie_ro: 2.9 (0.9%), parse: 0.98
        (0.3%), extract_message_metadata: 10 (3.1%), get_uri_detail_list: 0.87
        (0.3%), tests_pri_-1000: 10 (3.1%), tests_pri_-950: 1.06 (0.3%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 136 (40.6%), check_bayes:
        135 (40.1%), b_tokenize: 3.7 (1.1%), b_tok_get_all: 4.9 (1.5%),
        b_comp_prob: 1.34 (0.4%), b_tok_touch_all: 122 (36.3%), b_finish: 0.73
        (0.2%), tests_pri_0: 158 (47.2%), check_dkim_signature: 0.35 (0.1%),
        check_dkim_adsp: 1.87 (0.6%), poll_dns_idle: 0.54 (0.2%),
        tests_pri_10: 2.6 (0.8%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] Fix user namespace leak
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Fixes: 61ca2c4afd9d ("NFS: Only reference user namespace from nfs4idmap struct instead of cred")
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

nfs folks do you want to pick this up?

> ---
>  fs/nfs/nfs4idmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
> index 8d8aba305ecc..f331866dd418 100644
> --- a/fs/nfs/nfs4idmap.c
> +++ b/fs/nfs/nfs4idmap.c
> @@ -487,7 +487,7 @@ nfs_idmap_new(struct nfs_client *clp)
>  err_destroy_pipe:
>  	rpc_destroy_pipe_data(idmap->idmap_pipe);
>  err:
> -	get_user_ns(idmap->user_ns);
> +	put_user_ns(idmap->user_ns);
>  	kfree(idmap);
>  	return error;
>  }
