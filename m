Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3C7B75CA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 02:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbjJDAYW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 20:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjJDAYU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 20:24:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA21B4
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 17:24:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D6BC433C9;
        Wed,  4 Oct 2023 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696379056;
        bh=2plxz5SQQWtyDsNuzZaxJwb6zktWu0J8CUTGSOkbtDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RPV8usbpRHhtbtaLn4K3PRJZiI8GwSp7EOi6vhp842wHdZdujbyEQip/lGayR/HlL
         XpQpupXKjAf+Lo5yPkf+56u9hJ/qcY5Kb6tLLNwNJpjWPpThnmimxCMfvRzoDSbXdP
         YCc5hF9mmT7y9Au4JprUJHYQeCrDC9K7bAvQj9yjsTZQbYZ/CXykVjamxAlbYy743N
         d4+UJWIBdcxyEZ9SvylMr1mmijL5mzn0k+k37hZ/46xMy07NqCv/2fYTjOfDixR9Q/
         WNvZpa7HUJ74wRe4r3cC08L8VvQyRS2XUullVy2TYFr3ECujtp0cbuxhO3bpWHVkTL
         PvTkwy2xYf6sA==
Date:   Tue, 3 Oct 2023 17:24:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Message-ID: <20231003172415.13c44667@kernel.org>
In-Reply-To: <8631D22A-8050-4403-B03E-06F33C709184@oracle.com>
References: <cover.1694436263.git.lorenzo@kernel.org>
        <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
        <20231003105540.75a3e652@kernel.org>
        <F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
        <20231003120259.39c6609a@kernel.org>
        <8631D22A-8050-4403-B03E-06F33C709184@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 3 Oct 2023 23:00:09 +0000 Chuck Lever III wrote:
> To ensure that I understand you correctly:
> 
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index 403d3e3a04f3..f6a9f3da6291 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -72,3 +72,19 @@ operations:
>        dump:
>          pre: nfsd-nl-rpc-status-get-start
>          post: nfsd-nl-rpc-status-get-done
> +        reply:
> +          attributes:
> +            - xid
> +            - flags
> +            - prog
> +            - version
> +            - proc
> +            - service_time
> +            - pad
> +            - saddr4
> +            - daddr4
> +            - saddr6
> +            - daddr6
> +            - sport
> +            - dport
> +            - compound-ops

Yup! (the pad can be skipped since it's not rendered, anyway).
