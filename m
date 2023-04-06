Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A16D8BD5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjDFA00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 20:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjDFA0Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 20:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757247D9A
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680740736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnG+nCyPWB8ZL9Ap6fLZh9ezCdT+TIIsCMEMmA9isDc=;
        b=EXmP3vYYRWRmJJRhXqggrPi1F1uu+Px2PPChOJibgm3Iy2xeiePk+WOfQZu1yO6rZwQzHn
        TyRjQExsPrN0h7D8yQeWJU3VFabn5gyBuaXgqilAfs35cEtZOss7WZKqBMtgxes7zO/an/
        AzW/iwAdPfxBRjZHMURGqnb3Qf8tBNE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-xk0MfiuvPsafhzGtasD2Tw-1; Wed, 05 Apr 2023 20:25:35 -0400
X-MC-Unique: xk0MfiuvPsafhzGtasD2Tw-1
Received: by mail-pf1-f198.google.com with SMTP id m14-20020a62a20e000000b0062e320c3e8fso1220901pff.13
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 17:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680740734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnG+nCyPWB8ZL9Ap6fLZh9ezCdT+TIIsCMEMmA9isDc=;
        b=5IUz1g3SiFG+tQ4Z7WBqRKUvZmkbSREDMh/TWujvP6ehnRU+BZwq11obOUbc6k1LWi
         +bkXh4mzCxFQ7z3BtbPcu6j1XIdr9QZ/OH4sT0znQRVQ9EMclrlur+ddv0kX7U6DKAXy
         6f94mJ5QDB1EHM+m6W68K+XnRuZgG0spYW0WTxduK+SRMNlzNc1rMu79OGqWebv1ZevD
         a9AJSdOQy3pqrVl+w3eOrUboEoz+lxsQknf+5V+wnAaPTWI20nxIPfYt5GYBvVOkK8Z/
         7mmCFyrzAEBvfZslum79bRLK90ubgT0UHTeNMy8CfFU5xxfSHJQ8p5sguKCXJI6wl6zk
         C5Mw==
X-Gm-Message-State: AAQBX9fycgmN0jMsHlcYj8KWJEdXtee+NNkMupd2qq4Gf4svY04sWwmP
        +a1vi9d93Cv/kh/QuFy4+H9r+M35vWrpq0+7XLWJN/Go+Ap5t+23i6twjI8r3es2R+SgmRGd4jH
        3SPw6HSGaR8g1erlqYj5W
X-Received: by 2002:a17:90b:17c7:b0:23f:7d05:8765 with SMTP id me7-20020a17090b17c700b0023f7d058765mr8769205pjb.10.1680740734094;
        Wed, 05 Apr 2023 17:25:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YchunmOlWsqR1uqhyleFq+e6uT40JJEkEYVgwX9vsqmDYfOCSrK9/Althx8xc8uY/FzfvVaQ==
X-Received: by 2002:a17:90b:17c7:b0:23f:7d05:8765 with SMTP id me7-20020a17090b17c700b0023f7d058765mr8769184pjb.10.1680740733840;
        Wed, 05 Apr 2023 17:25:33 -0700 (PDT)
Received: from [10.72.13.97] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ce21-20020a17090aff1500b0023d386e4806sm1864484pjb.57.2023.04.05.17.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 17:25:33 -0700 (PDT)
Message-ID: <7c2bfeb5-3c93-1fc9-cc1e-e7350b406ea1@redhat.com>
Date:   Thu, 6 Apr 2023 08:25:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Content-Language: en-US
To:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        djwong@kernel.org, anand.jain@oracle.com
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/5/23 01:14, Zorro Lang wrote:
> The fstests supports different kind of fs testing, better to cc
> specific fs mailing list for specific fs testing, to get better
> reviewing points. So record these mailing lists and files related
> with them in MAINTAINERS file.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>
> If someone mailing list doesn't want to be in cc list of related fstests
> patch, please reply this email, I'll remove that line.
>
> Or if I missed someone mailing list, please feel free to tell me.
>
> Thanks,
> Zorro
>
>   MAINTAINERS | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09b1a5a3..620368cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -107,6 +107,83 @@ Maintainers List
>   	  should send patch to fstests@ at least. Other relevant mailing list
>   	  or reviewer or co-maintainer can be in cc list.
>   
> +BTRFS
> +L:	linux-btrfs@vger.kernel.org
> +S:	Supported
> +F:	tests/btrfs/
> +F:	common/btrfs
> +
> +CEPH
> +L:	ceph-devel@vger.kernel.org
> +S:	Supported
> +F:	tests/ceph/
> +F:	common/ceph
> +

LGTM and feel free to add:

Acked-by: Xiubo Li <xiubli@redhat.com>

Thanks,

- Xiubo

