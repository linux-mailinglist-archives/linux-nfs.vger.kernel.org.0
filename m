Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D476375EEC2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjGXJMe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGXJMd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 05:12:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49211F
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:12:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9936b3d0286so734813266b.0
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189950; x=1690794750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFfUUb64VwU5Bf2t0RGXoIL3zpxOQktE4vJEtGl+Hsk=;
        b=jzBYnibjKwJZxeyNGCpt6tmmhp3VV6wsH1G+XLQyVrx17OO9IF2rvmZR566uZwZHpo
         LeM331dc48nxF7Jf6EVIVAvO8j2VILnDsuUD1JJ61pIG2ygoR8G8qAcvAWqgOQ+c8l2W
         3R6u3mZQ9cH2Q7oZZugreEXGtwadA0NTX8trGsxsTZCa7w2/dqC/gAO1XPmncxbDPaqv
         lCijIzMTX3wvrsfxYGvWZLfKUjSP94JyZvYsuIiONwRWRDkp/aCWZLEFTALJgDpX5IWi
         8Gdtidf1cLrKprSQLpNWd+V8bSINEZJ1qbAGRk66iSTbUli43M36lukjGDi7ScHIaVtp
         9k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189950; x=1690794750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFfUUb64VwU5Bf2t0RGXoIL3zpxOQktE4vJEtGl+Hsk=;
        b=LqidF3CpS6dDlcA+HU1EKByYRIeGQZM5NzE2Zp12EjjpbJK5q5zIXEpY1u//yBfIhB
         eE6TfMO+2CPT9DZShtW3QYap5veTAIaUIqbqBdW/AhOL1RvVXlzcAN1KViWFLnlMR0Mp
         mt5EIuuspC2uoOtDMSOIpYaO6vX2CN8iXP0IsItvlqJmlxV/SsTHrFcf2O6+zCdKxikE
         X0n21iqvDXJdQE5hMMfrPX4eW43k17WS2xRfVEjHIO8s7C4o26axak6+hIBbf8OV+cvA
         0Aj+yqAH2SKzue1zsL8RzhCXJDjAPGpiqk34oL9kMwjUOsa6JOOF2yExaqcYCz9nl9Mh
         LueA==
X-Gm-Message-State: ABy/qLZHHtWx8aYQ5AvGoePfzauPiX52mgP65CwKKlvAGz8i+UcQAAIC
        FBa/YL8u2UupUCvbwGW8lIs=
X-Google-Smtp-Source: APBJJlFMEo9C7IOQSxBe4Pxpnxau9VZCabE1vyVukGa1CeArUgFnmYWCnhob1V0gfKQcJR8NuoW42Q==
X-Received: by 2002:a17:906:10dd:b0:99b:48b9:8e45 with SMTP id v29-20020a17090610dd00b0099b48b98e45mr10257164ejv.76.1690189950349;
        Mon, 24 Jul 2023 02:12:30 -0700 (PDT)
Received: from eldamar.lan (host-95-249-180-187.retail.telecomitalia.it. [95.249.180.187])
        by smtp.gmail.com with ESMTPSA id qk15-20020a170906d9cf00b009929d998ab6sm6367727ejb.131.2023.07.24.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:12:29 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id B8C81BE2DE0; Mon, 24 Jul 2023 11:12:28 +0200 (CEST)
Date:   Mon, 24 Jul 2023 11:12:28 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Andreas Hasenack <andreas@canonical.com>
Cc:     Steve Dickson <steved@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Ben Hutchings <benh@debian.org>, linux-nfs@vger.kernel.org
Subject: Re: Always run rpc-pipefs-generator generator (was: Re: Why keep
 var-lib-nfs-rpc_pipefs.mount around?)
Message-ID: <ZL5AfARR1rrlPEdz@eldamar.lan>
References: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
 <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com>
 <7bfafe56-0c13-a32d-093b-4d3684c4f2c7@redhat.com>
 <CANYNYEEA1CHwvZhrr2W0-BcGR1Rm50QSTdHwb0pygz4z0ZY=uQ@mail.gmail.com>
 <ZKpkDG2kTWVFSNiZ@eldamar.lan>
 <A172CCB3-973D-4A26-A8AF-3D654F4D444F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A172CCB3-973D-4A26-A8AF-3D654F4D444F@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Mon, Jul 10, 2023 at 10:39:43AM -0400, Benjamin Coddington wrote:
> On 9 Jul 2023, at 3:38, Salvatore Bonaccorso wrote:
> 
> > Hi Steve,
> 
> ...
> 
> > FWIW, in Debian we have applied the respective change. The idea would
> > be to only depend on a single mechanism for setting up the mounts
> > rather than a combination of the two (the generator and the static
> > mount unit). For this reason we have applied the attached patch, and
> > are not installing the units that we will let the generator produce,
> > that is var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target
> >
> > We in Debian for long have diverged too much from you upstream,
> > causing that we lacked behind several new upstream version and stuck
> > with old versions in stable releases. We want to avoid running into
> > that again in future. So if this make sense to you, would you apply
> > the same (or as you prefer similar) change to you upstream?
> >
> > On one side so you could apply Andreas Hasenack patch, secondly
> > installing the var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target
> > could be dropped (note no changes to the other units needed as the
> > repsective needed dependencies are generated by the systemd
> > generator).
> >
> > Ben, Andreas, please add what else is needed from your point of view
> > please!
> 
> I don't think I've seen the PATCH land on the list addressed to nfs-utils
> maintainer yet, but I could have missed it.
> 
> Otherwise it looks sane to me, but I could be missing some upstream case.
> 
> > Thanks a lot for considering this. If you have any suggestion further
> > how we can unify the Debian downstream to you upstream, let us know
> > please.
> 
> At Red Hat, we use "upstream first" as a leading principle.  If this change
> makes sense for upstream, send Adreas' patch along and I am sure Steve D will
> consider it or let us know why its not acceptible for upstream.

Andreas, could you sent a proper patchset please, so upstream can have
a look at it for inclusion? 

Regards,
Salvatore
