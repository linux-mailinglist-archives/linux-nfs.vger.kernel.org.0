Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718667B3A6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jan 2023 14:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjAYNpQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Jan 2023 08:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjAYNpP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Jan 2023 08:45:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081B582AC
        for <linux-nfs@vger.kernel.org>; Wed, 25 Jan 2023 05:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7693F611C8
        for <linux-nfs@vger.kernel.org>; Wed, 25 Jan 2023 13:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAD4C433EF;
        Wed, 25 Jan 2023 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674654296;
        bh=tbzFbHv5ZoD7uxMN+SSmpcR1SIw4yTY3P91l8xoyPB4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=j71bVbUja3k7NDdjRO/OTku2MiAL08MtDjBQuqWjrijvzNbaeARhCccwGH6ewDjCl
         86SeiOYMkfZrPXqmgxoabgZT6wUCIRhBfmuA7RpwXyYCJzBcaJrS8H98r3e0l4jtKn
         I7rcY2ubYfWrOJg54KCYmZC/TeCw8KaaxiSF8LWh7+w52RoRPJi97hw8+GDxqCjJ1N
         ynnkS8zGxYAyt88+EGUaSMQjhqCKfuSDFqg4ZMEjHMlqacWv1TkinOyY7OzNnwJUxG
         LqI+pU2q4x9CV5/Zit7/6ep/L8Tl7ojPkdDiqVZeusW4PWMRuVzkah6rbycKGkbDGM
         Rmv4iKHHuD5OQ==
Message-ID: <e0848ca52dcb3e8ead30ba9b2b67b6bd7584e6b7.camel@kernel.org>
Subject: Re: [PATCH v1 1/2] SUNRPC: Clean up the svc_xprt_flags() macro
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Wed, 25 Jan 2023 08:44:55 -0500
In-Reply-To: <167459281558.15600.1555010122091924488.stgit@manet.1015granger.net>
References: <167459281558.15600.1555010122091924488.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-01-24 at 15:40 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Make this macro more conventional:
>  - Use BIT() instead of open-coding " 1UL << "
>  - Don't display the "XPT_" in every flag name
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/sunrpc.h |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
> index 37604e0e5963..3ca54536f8f7 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1819,20 +1819,20 @@ TRACE_EVENT(svc_stats_latency,
> =20
>  #define show_svc_xprt_flags(flags)					\
>  	__print_flags(flags, "|",					\
> -		{ (1UL << XPT_BUSY),		"XPT_BUSY"},		\
> -		{ (1UL << XPT_CONN),		"XPT_CONN"},		\
> -		{ (1UL << XPT_CLOSE),		"XPT_CLOSE"},		\
> -		{ (1UL << XPT_DATA),		"XPT_DATA"},		\
> -		{ (1UL << XPT_TEMP),		"XPT_TEMP"},		\
> -		{ (1UL << XPT_DEAD),		"XPT_DEAD"},		\
> -		{ (1UL << XPT_CHNGBUF),		"XPT_CHNGBUF"},		\
> -		{ (1UL << XPT_DEFERRED),	"XPT_DEFERRED"},	\
> -		{ (1UL << XPT_OLD),		"XPT_OLD"},		\
> -		{ (1UL << XPT_LISTENER),	"XPT_LISTENER"},	\
> -		{ (1UL << XPT_CACHE_AUTH),	"XPT_CACHE_AUTH"},	\
> -		{ (1UL << XPT_LOCAL),		"XPT_LOCAL"},		\
> -		{ (1UL << XPT_KILL_TEMP),	"XPT_KILL_TEMP"},	\
> -		{ (1UL << XPT_CONG_CTRL),	"XPT_CONG_CTRL"})
> +		{ BIT(XPT_BUSY),		"BUSY" },		\
> +		{ BIT(XPT_CONN),		"CONN" },		\
> +		{ BIT(XPT_CLOSE),		"CLOSE" },		\
> +		{ BIT(XPT_DATA),		"DATA" },		\
> +		{ BIT(XPT_TEMP),		"TEMP" },		\
> +		{ BIT(XPT_DEAD),		"DEAD" },		\
> +		{ BIT(XPT_CHNGBUF),		"CHNGBUF" },		\
> +		{ BIT(XPT_DEFERRED),		"DEFERRED" },		\
> +		{ BIT(XPT_OLD),			"OLD" },		\
> +		{ BIT(XPT_LISTENER),		"LISTENER" },		\
> +		{ BIT(XPT_CACHE_AUTH),		"CACHE_AUTH" },		\
> +		{ BIT(XPT_LOCAL),		"LOCAL" },		\
> +		{ BIT(XPT_KILL_TEMP),		"KILL_TEMP" },		\
> +		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" })
> =20
>  TRACE_EVENT(svc_xprt_create_err,
>  	TP_PROTO(
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
