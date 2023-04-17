Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B0B6E49EA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDQNbM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQNbL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 09:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E0F5
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681738225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0XyvvSMhsrQHVV1gbqau/zzA7diR74fJ5XXhH8LNi4=;
        b=I8TU4hLqBasYp3PLWgE6Qgvlz6ITPY6UD6tiVk6M8QXQw+2unA+4FBAvLZhnQ9dzZ0IhEu
        WczlaOHU9u+2I2YzBwz2twNKVhu/7rbl384rnheAPV43QN0Q5C/yNfZoLPi+DQ8k+DnaN3
        wD3Hgf0yRhwHWgntdO8Gl1S/fmwD4Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659--mXldnzYNJebticL3MAYWA-1; Mon, 17 Apr 2023 09:30:23 -0400
X-MC-Unique: -mXldnzYNJebticL3MAYWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 617EF185A790;
        Mon, 17 Apr 2023 13:30:23 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.34.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 539CC2166B26;
        Mon, 17 Apr 2023 13:30:23 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id DF6BA1A27F5; Mon, 17 Apr 2023 09:30:22 -0400 (EDT)
Date:   Mon, 17 Apr 2023 09:30:22 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix failures of checksum Kunit tests
Message-ID: <ZD1J7jL0+tpaYiSq@aion.usersys.redhat.com>
References: <168166470652.2679.10078886564885712799.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168166470652.2679.10078886564885712799.stgit@bazille.1015granger.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, Chuck.  That fixes the test for me.

Tested-by: Scott Mayhew <smayhew@redhat.com>

-Scott

On Sun, 16 Apr 2023, Chuck Lever wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Scott reports that when the new GSS krb5 Kunit tests are built as
> a separate module and loaded, the RFC 6803 and RFC 8009 checksum
> tests all fail, even though they pass when run under kunit.py.
> 
> It appears that passing a buffer backed by static const memory to
> gss_krb5_checksum() is a problem. A printk in checksum_case() shows
> the correct plaintext, but by the time the buffer has been converted
> to a scatterlist and arrives at checksummer(), it contains all
> zeroes.
> 
> Replacing this buffer with one that is dynamically allocated fixes
> the issue.
> 
> Reported-by: Scott Mayhew <smayhew@redhat.com>
> Fixes: 02142b2ca8fc ("SUNRPC: Add checksum KUnit tests for the RFC 6803 encryption types")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/gss_krb5_test.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
> index aa6ec4e858aa..95ca783795c5 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_test.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_test.c
> @@ -73,7 +73,6 @@ static void checksum_case(struct kunit *test)
>  {
>  	const struct gss_krb5_test_param *param = test->param_value;
>  	struct xdr_buf buf = {
> -		.head[0].iov_base	= param->plaintext->data,
>  		.head[0].iov_len	= param->plaintext->len,
>  		.len			= param->plaintext->len,
>  	};
> @@ -99,6 +98,10 @@ static void checksum_case(struct kunit *test)
>  	err = crypto_ahash_setkey(tfm, Kc.data, Kc.len);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
> +	buf.head[0].iov_base = kunit_kzalloc(test, buf.head[0].iov_len, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf.head[0].iov_base);
> +	memcpy(buf.head[0].iov_base, param->plaintext->data, buf.head[0].iov_len);
> +
>  	checksum.len = gk5e->cksumlength;
>  	checksum.data = kunit_kzalloc(test, checksum.len, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, checksum.data);
> 
> 

