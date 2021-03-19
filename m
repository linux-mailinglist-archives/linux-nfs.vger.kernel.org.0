Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6D342071
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCSPCt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCSPCj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Mar 2021 11:02:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C53C06174A
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 08:02:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b7so10243868ejv.1
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUoOu7agSTM4o48gPJLYLcyZ5QlQnr4TzAJ4RXshIiA=;
        b=JinUrHEY3FUG3OBWYgdkbr0nNigXWVhQbYi/zz2Lyw2IQscLLz+ylaA59Vz2ZQIaj2
         XFWDWbhnWISuQXmnhJ37LtdkNW00EcCi7y6vq1DmMb9OsXX+aEjgyJpHFwqTHeVXhOl2
         uK+Qa21XBNANTUm/wEPUOZga/pcdojyhH1bTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUoOu7agSTM4o48gPJLYLcyZ5QlQnr4TzAJ4RXshIiA=;
        b=TghQOS0m8Vnlr8ortdwBADlVBeOOEMZ07ga8hezqRYPlDGRR5mkjmYRlKYb9CNCpQU
         eJW4lZx13dZsCuG5DZHWgLZXIF23Gqm5juUQf2tQNVFZ0vd9CiWszSs6316RT4Wlt5xB
         QcVGliAQFauup+a00uf7xWwr1kZJwkNjx5nnE05oDI8kfkrMR0ynrFec0hqB9gMw1S7B
         cuib9NO1TK1okaftjq1OxHGnO62xBTUKf5utq3SfNcGfuAWddyD6z0+xki7CbVVlhH0I
         HbjTj2F6aJlPvELNT40vyS6Q4+krpWFikR8EVjpvxzdJHsk2/y5RMavwFviPx6cEtNmR
         fSXg==
X-Gm-Message-State: AOAM531N2ag+JU4QeKTClzaws8PkcUAjoEPpf+TvJArJBD2TQEr6oFRE
        7nFaEUhEVo9hhnXErR63gY4aQdc9CyjPWk/R
X-Google-Smtp-Source: ABdhPJyUA/30/66Jrqj8l7qBqYGrm5xt5nwCoPgbzhEV3H6DWZV55EC2udDYKycYf6M3J8cLgJ5CmQ==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr4992321ejr.136.1616166155402;
        Fri, 19 Mar 2021 08:02:35 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id sb4sm3858358ejb.71.2021.03.19.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:02:35 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:02:34 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-nfs@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] SUNRPC: Output oversized frag reclen as ASCII if
 printable
Message-ID: <YFS9CuBO/FxJdRGB@chrisdown.name>
References: <YFS7L4FIQBDtIY9d@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YFS7L4FIQBDtIY9d@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey folks,

Let me know if you'd like more evidence that this is a persisting problem. Also 
more than happy to change the generation of the whole debug string to go into 
svc_sock_reclen_ascii or use LOG_CONT if you'd prefer to avoid the multiple 
ternaries (but the latter probably needs some thought about how it interacts 
with ratelimit).

Thanks,

Chris
