Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4E649E51
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 12:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiLLL70 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 06:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiLLL7Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 06:59:24 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C26EF5AC
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 03:59:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 487845C0140;
        Mon, 12 Dec 2022 06:59:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 12 Dec 2022 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1670846360; x=1670932760; bh=Tqxn3RgoCF
        QG4+wtTdo6hcuOyAnCUuOHAQygGvd49Q8=; b=U2soLQAsSMrSnCHCZ3cgX6bauC
        ZcNfzn4DJtoRPktGJJoVeGbBgpaHx2UecmKGeBc3TNIY+oWgVf8sQS/7yh0eH+vv
        drgsNnIl/zsjm53WfhZdNTn98+aZ5746C9MtaCfntcIW5RBS1ks70y45akESBK72
        Z6/jL3BQ8AWMunE2QEvXb0g42+DqvXJbSSEvrRKRWzx5YvBHxYqoZiqeGKT6Wf1A
        L4xSBbk3KZQHRczyRFpVFICt7YU+n5sZTFNhEA9wLv09EOD74cM4cLuMyB25orCO
        BCqSAQW1x/gZmMLDwjd49NDku+A2L0tELb/nP+Yo3T0sp/6cy3Y9swqWO79w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670846360; x=1670932760; bh=Tqxn3RgoCFQG4+wtTdo6hcuOyAnC
        UuOHAQygGvd49Q8=; b=Xjup9kiC9OU9sZfzPFSwfntZDC2eZngLa81FpIzVEikG
        +mvQx3OWuXJR3Q2aM0DYuPl2vYCGTM+eIBF2j/7JdqeBh6aMmzvKwAyCnhAH8J+R
        F3FHxjVO+Rcuj/XeKlVXF+qw3s8UmE+k7MJ8/q09tM5R4yK4KpBRE3+/d31W4a5X
        M48WD9w/YtKHup3OHNy5FC7tZtMey0N36j0PdIZED3RArdF60LWtuPQMyEyNnuTN
        h3FE0Tc793ZwdQFBQZZf6gpG7tYyYtJmF/h2iWZT//MNzdOgwv2W8YuEwXMG2qnU
        SEpaaDZCT40LMXh3RNhoD0LHEna1yKNrljKpxI/wcA==
X-ME-Sender: <xms:lxeXY9tTjrThvQ9kXaG_z3s4clPZaGbevglS0zMV26rkZ8S1dO8EUg>
    <xme:lxeXY2eSyj-9YslPVeltSlN_SVayQqPa9vCTuX2Vk6ut82_aznlqCKOfkLBL8Mwv9
    z00lyxe49gM6A>
X-ME-Received: <xmr:lxeXYww4HWmyvuqaZECGvvfqPbxb5u_fFi-haEFOdUQmGU-vJMFNb8hzcU3t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:lxeXY0MRv1moWnJGHT9l6V_NUprznDVVTuVKcx8VSenSznFhFqBThA>
    <xmx:lxeXY99P5B-2gsPTXcg_v8kq8-7UTHVmAvMGjaX8DgeITDJS31Fhfw>
    <xmx:lxeXY0X4cjh9McPNlDaNRGX1n1ddF8NyBAiGZBeeSKFOrwSGoTLwkg>
    <xmx:mBeXYwVN7oCCk1zHejFJQvqwQDn39goYLNlRe0Uz4O4JPXIN19yGkA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 06:59:18 -0500 (EST)
Date:   Mon, 12 Dec 2022 12:59:15 +0100
From:   Greg KH <greg@kroah.com>
To:     Xingyuan Mo <hdthky0@gmail.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org, kolga@netapp.com, linux-nfs@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Message-ID: <Y5cXkyWUVf433sd5@kroah.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <CALV6CNOO-Ppv7QfqHo9RKivv-1NUrezbuYN2krrNu4REuchtMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALV6CNOO-Ppv7QfqHo9RKivv-1NUrezbuYN2krrNu4REuchtMA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 12, 2022 at 07:22:38PM +0800, Xingyuan Mo wrote:
> Can I share the patch with the linux-distros list, so that
> distros can do their own testing and preparations?

Be _VERY_ aware of the rules regarding that list before you send
anything as you are going to have some very strict rules put on you with
regards to what you must do once you post to them.

Personally, I would prefer if this gets into Linus's tree first so that
we can get it into a stable release before letting distros know about
it, otherwise you are forcing me into a very tight schedule that might
require you to tell the world about the problem _BEFORE_ the fix is in
Linus's or any stable kernel trees.

thanks,

greg k-h
