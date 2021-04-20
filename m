Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DAC36612F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhDTUxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 16:53:35 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:34689 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233682AbhDTUxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 16:53:35 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:53:35 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 926F96A519
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 15:27:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwyUlQ2m8mJLsYwyUln3Da; Tue, 20 Apr 2021 15:27:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oX7kcc6oTUH4hCr9MNRS/mgNqZEzNoA6YEngI4lAQ3w=; b=m3evWBu/v+Ol3BZL0pPhDfRsyy
        QhunriesClaCHCzAI3i+vONHutIjnv0OCufI9cnPrjUTpPV8+N26xJGthktTICwiSNmE7PlRVoKOr
        lSOi9fDV7KCG+kSP+Mh/V9qK2khk9SCeMsB5nDRAhtPgS8EX1FHFJ1ul736Il7Ph/AuHL4+GuQaIe
        Sj2kE5aCFyoUvyiGIpXuxlpY0QFtTPjvFmEdTOpjXrO//vmUkxgxT3OeYh3pf2SeMii8xxfAWMB06
        aefJkysCWf4rbCXgW9PLcSYgiAO6vWac8Me3TN4mWz4O60JZbtU1ase5ozztnt4orVIcpDtpsJuiV
        h1rdocAQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49070 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwyS-00397i-70; Tue, 20 Apr 2021 15:27:56 -0500
Subject: Re: [PATCH 016/141] nfsd: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <0669408377bdc6ee87b214b2756465a6edc354fc.1605896059.git.gustavoars@kernel.org>
 <BF1128CE-4339-4145-9766-4EE7A5F58B5F@oracle.com>
 <20201123224605.GF21644@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <eb3be82d-1930-673d-22e6-e76a5bc210b8@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:28:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201123224605.GF21644@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwyS-00397i-70
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49070
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 205
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/23/20 16:46, Gustavo A. R. Silva wrote:
> On Fri, Nov 20, 2020 at 01:27:51PM -0500, Chuck Lever wrote:
>>
>>
>>> On Nov 20, 2020, at 1:26 PM, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>>>
>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
>>> warnings by explicitly adding a couple of break statements instead of
>>> just letting the code fall through to the next case.
>>>
>>> Link: https://github.com/KSPP/linux/issues/115
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>> fs/nfsd/nfs4state.c | 1 +
>>> fs/nfsd/nfsctl.c    | 1 +
>>> 2 files changed, 2 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index d7f27ed6b794..cdab0d5be186 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -3113,6 +3113,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>> 			goto out_nolock;
>>> 		}
>>> 		new->cl_mach_cred = true;
>>> +		break;
>>> 	case SP4_NONE:
>>> 		break;
>>> 	default:				/* checked by xdr code */
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index f6d5d783f4a4..9a3bb1e217f9 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1165,6 +1165,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
>>> 		inode->i_fop = &simple_dir_operations;
>>> 		inode->i_op = &simple_dir_inode_operations;
>>> 		inc_nlink(inode);
>>> +		break;
>>> 	default:
>>> 		break;
>>> 	}
>>> -- 
>>> 2.27.0
>>>
>>
>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Thanks, Chuck.
> --
> Gustavo
> 
