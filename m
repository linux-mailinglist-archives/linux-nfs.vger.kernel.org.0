Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129D4BDC92
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358335AbiBUMxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 07:53:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358348AbiBUMxc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 07:53:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568521C10F
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 04:53:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vz16so33130246ejb.0
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIkxt07Z4ubFK1kFr3bnbEVzRqiPa8qpMf+645NMzTs=;
        b=Uc2b2bBbBADpRr8LS0IM6DNXV35/eiaAkUi+OmEsBdY3lHYUDNTmDyMI5IzsEBv1Fc
         GzKBUf+jIYCVnw8/ODWsPUMYdcCgqRRbTo0mU/J4jT+jnK81NcclFgb2oubn1YR0EJL7
         1Yb/MBM0Xj5Y8yx7BpgPI8hjgzdduB6cSHC6D3OOUhDS8cTYpNF1z1wTsq3CxhfZZ/zj
         9dJG07p9J2V1FvEbnX016FUEw3B3FRyaek+Z7oQnRj9D+mYbht0O4si+lOwkn49MCZvR
         OI3HNyBTWIdyZ4l3rjsHvct7hOiRjr51a9gjo1zPXjvBh7U6v9gaYwrYDMWU+o3d6y/E
         6kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIkxt07Z4ubFK1kFr3bnbEVzRqiPa8qpMf+645NMzTs=;
        b=kKwFCIoATRcVWK66CjZ/L1ECayTItdtJgpKMzhJlvxjTdhI6gYHhwPr3lQUuodBVxJ
         zf4t87oysRAv7WWXklZfDLFnYHD8wBdmkVVaW7whHWJxHIrMf7yJFvrYN6cs4Dn6Q8Nm
         C2Yovkcw2oq4UBWUMBVlzeJnQUUpDqVqFaaJkrH+rAfThncz5hG7N2N4entnXWgB/iMz
         VOyds/gbHYdx5DWfk4mxD89gaxycVfBc8H9/V/zA0YfoFRHVbnVPDSaVh6/5A6zzTy7z
         KkGV47bBLt20bBUikThxrcWH1j9E6f5L8hJXT4yShxYFbFD4xcHS3w68AJJqsFQfSgpX
         9ZaA==
X-Gm-Message-State: AOAM530L3q5u2IO9sq3xhcxyUgmn2klXCM/skLTtUBISTq2pTI7IgBJi
        2Y4xXhh6burRJx3+1FJko5dqAU/IA1hzxrhhgeElRD2kzXnm6w==
X-Google-Smtp-Source: ABdhPJyBilyTg3haTbBDLdnhBsTP+YZz6ItmtmgDliXkE3DOX8jVPfcHIOwv7HcD8HuU3Fxh9A5UreKMER6b7c8+lrY=
X-Received: by 2002:a17:906:e13:b0:6ce:21ca:1b91 with SMTP id
 l19-20020a1709060e1300b006ce21ca1b91mr16135536eji.193.1645447987899; Mon, 21
 Feb 2022 04:53:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com> <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>
 <3849f322-94f7-fe73-4e08-1660be516384@talpey.com> <66383037-8263-4D7B-B96C-C9CED24042FC@oracle.com>
 <164523140095.10228.17507004698722847604@noble.neil.brown.name>
 <194829a2c280364faa6e9c70dbaee463101453a7.camel@hammerspace.com> <164543035585.17923.4120371632609985618@noble.neil.brown.name>
In-Reply-To: <164543035585.17923.4120371632609985618@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 21 Feb 2022 12:52:32 +0000
Message-ID: <CAPt2mGM=TAbz1rRYL-sxcoWyO+53a3mFWt5Waz8b4o4zdrbXbg@mail.gmail.com>
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I certainly have nothing to contribute in terms of implementation
details (you all know best). I will happily test and provide numbers
though.

I guess it was just one of those (out of the box) corner cases where
NFSv3 > NFSv4.2 that I thought was worth highlighting.

For now, I probably have no other option but to use NFSv3 for any high
latency clients that require lots of concurrency as future changes to
the server side per client slot count logic is unlikely to make its
way into this generation of Linux distros (e.g. RHEL8).

Daire

On Mon, 21 Feb 2022 at 07:59, NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 19 Feb 2022, Trond Myklebust wrote:
> > On Sat, 2022-02-19 at 11:43 +1100, NeilBrown wrote:
> > > On Sat, 19 Feb 2022, Chuck Lever III wrote:
> > > >
> > > > For the Linux NFS server, there is an enhancement request open
> > > > in this area:
> > > >
> > > > https://bugzilla.linux-nfs.org/show_bug.cgi?id=375
> > > >
> > > > If there are any relevant design notes or performance results,
> > > > that would be the place to put them.
> > >
> > > I wonder if I have a login there..
> > >
> >
> > If you're having trouble setting one up, then let me know. I should be
> > able to help.
>
> Thanks.  I couldn't find any evidence in email history of ever having
> one, so I tried creating one and it went completely smoothly. :-)
>
> NeilBrown
