Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE465E28C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 02:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjAEBkK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 20:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEBkJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 20:40:09 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 17:40:08 PST
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2082019
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 17:40:07 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C94177151; Wed,  4 Jan 2023 20:33:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C94177151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1672882408;
        bh=LxA8aiION8SSM2DrLvmGs+UTyYqxQibf1bPZA+xzRso=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Bfvcch+/kwRgBZZhT4q0pHyw9l3btd8dVoXRbzhzg5uu0BHSKuVq7tfo45Giq2MGV
         cRssSVJWa5g8Bmm0Q7h6+PCVW+a9oewLcq/tjA5aAdHFaBiCOLBY9jyCmx8nF8TXVq
         X+Gxpfql1IcVbDQ5Rizn1x9f4fDR/HXKWOQDS6zw=
Date:   Wed, 4 Jan 2023 20:33:28 -0500
To:     Liad Oz <loz@infinidat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Bundling pynfs as a python package
Message-ID: <20230105013328.GA12852@fieldses.org>
References: <CAEdO7htksvMy7TBSLupmYbXqWf427y5byGyuXSW=APn2ZUCKYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdO7htksvMy7TBSLupmYbXqWf427y5byGyuXSW=APn2ZUCKYQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sigh.  So, last year I thought I'd continue pynfs maintenance on a
volunteer basis, but I don't think I'm going to after all.  Is anyone
else interested?

I could just blindly merge things like this and push them out, but it'd
really be better to have someone that will actually take the time to, at
a minimum, do some testing....

--b.

On Tue, Jan 03, 2023 at 01:24:42PM +0200, Liad Oz wrote:
> In my company, we want to integrate pynfs as part of our python
> testing environment. To do this, we need a package that can be
> installed using pip. Currently, it is not possible to turn pynfs into
> a pip-installable package due to the directory structure. I have been
> working on a branch that introduces major changes that fix this issue
> https://github.com/LiadOz/pynfs/pull/1/files.
> 
> With this new branch, to install the package you need to run pip
> install . in the root directory. For a local installation, run pip
> install -e . (which replaces the use_local modules). I have also
> updated the README with these changes.
> 
> After installation, several scripts should be automatically added to
> the path (which is why using a virtual environment is recommended):
> nfs41server, nfs41testserver, nfs41testclient, nfs41proxy,
> showresults. I have checked these scripts and they seem to work.
> 
> Please note that I have not finished making all the changes needed for
> nfs4.0. I could take the time to complete these changes if you think
> the bundle changes can be merged into master.
