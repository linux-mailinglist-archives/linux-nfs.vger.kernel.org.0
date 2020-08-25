Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527BA250CCE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Aug 2020 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHYAOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 20:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHYAOv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 20:14:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE866C061574;
        Mon, 24 Aug 2020 17:14:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so5892874pfb.10;
        Mon, 24 Aug 2020 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6iNvXGtlWVHCZui7UJjc+81HAZJSDqhOOP23PD5lEuE=;
        b=htou3NmFkJ/0pt6eIXd2au79Zj0YZkSufBGug85sV8+pMMuFp4HZ6XmsC2wYajAe8w
         2xEsaIGDtiJDNH6eUgD7IKIQOzicKafoYKlmASjt1PqAZB2Xfyyhgq4gK0vk1/2IdXHS
         RHFowNIf5BjcHr/8znTXLTjsVslaKd1Uq06c7iG2780RTm2nD9z8ugY6RL3ZmqTmJZUG
         81Yn7yePXhAGAL1/loJ+CbbJAMhS/jGN+R1nsSGHVVMM/0cGmQmpj2UkU4CjDZDm80Yv
         6XjL7O/YJtBZkGCogrFOhPi05AkkxE9U7pay1au8Bva6dgbDKFV49JearvnkLoy47roc
         4yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6iNvXGtlWVHCZui7UJjc+81HAZJSDqhOOP23PD5lEuE=;
        b=inrMx3MRNYKq3oXmxY5H3PIJXACTW4ak+5sGyZl33TpbM6rFe37OCwgVTNru+3k08x
         nj3AU7zqNtdRM90NS0nYbKUwMsGEYZ89dZcWErdQ8cwx/gfhwixW4xNPpdkR6cnFQNBp
         zkC6B6lQ5P1BT0SO8lOpN1dCrnRvVyv4m8nQXN3jQbl4MpFVYlAIW2KdxiJqs/F1krsA
         s/FtOO/PZUi3RmJooDy8OSzYj4IEWho9CBUwF6M4oTttJY2WCz4IzeoanPRsCaJC/ykt
         ot3E+AhLnFn8qFd8xFfqm4I+84NX4k3gMsMBfma15uLTcmwRRku6phHhbOk9ekNvMCkb
         M9KQ==
X-Gm-Message-State: AOAM53266euuvDKnFxOYc1rBjnbK7E/c8Bw33eav+mK4rB6J4bxsAAmi
        QmjDJLMPWm9gh40qwi8eL1A=
X-Google-Smtp-Source: ABdhPJxxIiZq0nxKe4dr4nofk8GJVRxc4SAZ3OQNBMOWNtgcakWJKrsBltbpWcjBsTYWfSpNBK9VdA==
X-Received: by 2002:aa7:99c2:: with SMTP id v2mr5985799pfi.274.1598314490244;
        Mon, 24 Aug 2020 17:14:50 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q13sm653411pjj.36.2020.08.24.17.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 17:14:49 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:14:42 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute
 handlers
Message-ID: <20200825001442.3auz3iqczeefjeli@xzhoux.usersys.redhat.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
 <20200623223904.31643-13-fllinden@amazon.com>
 <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
 <20200821160338.GA30541@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <62aa76de0ea316c029b7f9c22cf36c92b8cba2d9.camel@hammerspace.com>
 <20200824001345.nszimqfcsumd4xil@xzhoux.usersys.redhat.com>
 <20200824161657.GA25229@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824161657.GA25229@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 24, 2020 at 04:16:57PM +0000, Frank van der Linden wrote:
> On Mon, Aug 24, 2020 at 08:13:45AM +0800, Murphy Zhou wrote:
> > Thank you guys explanation!
> > 
> > I'm asking because after NFSv4.2 xattr update, there are some xfstests
> > new failures about 'trusted' xattr. Now they can be surely marked as
> > expected.
> 
> I have some patches to xfstests that, amongst other things, split 
> the xfstests xattr requirement checks in to individual namespace
> checks, so that tests that use "user" xattrs will be run on NFS, but
> others, e.g. "trusted" do not.
> 
> I should clean them off and send them in.

That's perfect. Thanks!

> 
> - Frank

-- 
Murphy
