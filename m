Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514274AB8B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2019 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfFRUS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jun 2019 16:18:27 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:46580 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfFRUS1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jun 2019 16:18:27 -0400
Received: by mail-io1-f43.google.com with SMTP id i10so32730285iol.13;
        Tue, 18 Jun 2019 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=F/b8q0IoryqzqljR+aY3A/nQs+X+UnGu+cJRE0X6+kc=;
        b=ubskdkGAaS7I9WauUa392VA2/X04XG/ZlxmvO4/bf5kfxfgfYGsVZv+VfUYswDZRpX
         0qdtGzzHRgJHcuJRKw9JlOrD4+phS6FTHflsFxcTx7MIBxGH5cUHFjNYG4pB45K7DRwC
         m/2wzR5bbzKESw/Y0JNj5ACdxAMQ9S6G6PWvSD6kvoFiqcNbQJOTdtbCl465Fzda4pea
         Vx/VEjrhk8bgXBq/dY9DTR4jijwDBUk0fxSMscnzCqJKlZ5e2TaRAIqJyx3yMM+blPNM
         8H9mxB5RvTkf/h2H3fgIOOIslWv6TvXx6LVECPalQT2VqrUpIBtNys5Ef5F4KrbLRKlT
         KjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=F/b8q0IoryqzqljR+aY3A/nQs+X+UnGu+cJRE0X6+kc=;
        b=CWj2G6dQxDjVDTrXbrff2tYh+f7pb+1aChtEbB8lz/SguWH9Jx6yyr5mPBc4kxESAV
         j+26PlJivtzOAMts1u3tA4PKvEbxhLovq/RIory+LQkdVTvHGwHb4J1ksLqOK5eXx6hZ
         5iEAySc0+w4ebrE4jcrGpkw6jJmIEPBCmcMkGeJbXPFk2UFMoKAIuL8KJewhuxIZhQQE
         vX6BsDX9Q39kfHR3gLWMcGizINRhUVJbHG3FX6264OUS75sqDcp3+kw0Az2QQxFwKNWa
         8IFzii83J3mN6Lxox25hC+V+YsIdEqaZF28yMsLZ2YD2hdWdaROyj3r5q/24gTOKSlfv
         ICsw==
X-Gm-Message-State: APjAAAVPum9qts+4HVxirXdUfK7ounTU67KabU3cy31jajPE1Sc+mOms
        uUbpR99vhNbKE2cIxxUcwCaCH8W9834=
X-Google-Smtp-Source: APXvYqz68QuERrn5/x1JV707IzEKgbEpnIVAnXAAs7SYTVAhJ7ZW2vWFVk02kbK2Re5BDPeO9YY1mg==
X-Received: by 2002:a5e:9308:: with SMTP id k8mr7178493iom.143.1560889106192;
        Tue, 18 Jun 2019 13:18:26 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.googlemail.com with ESMTPSA id c1sm12369542ioc.43.2019.06.18.13.18.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 13:18:25 -0700 (PDT)
Message-ID: <7d335b53c9878865cef1de83960701c0ece4e611.camel@gmail.com>
Subject: Re: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as
 TIMER_DEFERRABLE (431235818bc3)
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Date:   Tue, 18 Jun 2019 16:18:24 -0400
In-Reply-To: <313d971a-96ab-c7f0-34f5-631bb5f39e49@nvidia.com>
References: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
         <b2c142996bc25aff51a197db52015bf9222139fe.camel@hammerspace.com>
         <36e34e81-8399-be71-2dd6-399d70057657@nvidia.com>
         <313d971a-96ab-c7f0-34f5-631bb5f39e49@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On Tue, 2019-06-18 at 10:35 +0100, Jon Hunter wrote:
> Trond, Anna,
> 
> On 12/06/2019 15:23, Jon Hunter wrote:
> > On 05/06/2019 23:01, Trond Myklebust wrote:
> > 
> > ...
> > 
> > > I'd be OK with just reverting this patch if it is causing a
> > > performance
> > > issue.
> > > 
> > > Anna?
> > 
> > Any update on this?
> 
> I have not seen any update on this. Do you plan to revert this?
> 
> We are getting ever closer to v5.2 and this problem still persists.

Hi Jon,

Sorry it took me so long to see this. I've applied the revert and
pushed it out to my linux-next branch. I'm planning to send it with
some other bugfixes this week.

Anna
> 
> Thanks
> Jon
> 

