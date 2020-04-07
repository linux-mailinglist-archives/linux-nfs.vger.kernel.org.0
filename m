Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA21A085E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGHdy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 03:33:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGHdy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 03:33:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so2624159wrc.8;
        Tue, 07 Apr 2020 00:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgXMyzs13NuYA6W3haexk1rgQVEgjk0KCFI11uwcdlc=;
        b=NuXUbyWhm2z6g4BSsw7fmGUCh7P5NzugVSQB2w6jW2cNSVcpRIU82SKZfgDlBlxosP
         pDwupOge9Qyc7lAAkA+lRb1yk2II+GETPeZgiB2G72zuHxwGf1wOM9v0oAta2dFD4ia+
         E63aEMZPvLoCuWv1iXUVlSn3KNpCnHbx/vT7PeE9EySgLnyQ4Lvow8B4z+Alux2Jgg4W
         XSAyPI/TgZy+zCTgFIKbP+qy5BqL8EZc2d8J9jBq5Xnmuo9ejFy3RwK7NnBJXDiUJ25/
         EJl04HyI2ENSw4yelPZBififdVwO84Tdo3+pg1uUGDRHZTb+Zh8A4znWjd3Q6dEFLmVM
         LGtw==
X-Gm-Message-State: AGi0PuYA2x4YDBiLk+FOtBCXJT/e8UuuV2T4WCKY6uhvHEt9Sjpw0jro
        vMJJn3RvBu0L9IV/ESYTZa0=
X-Google-Smtp-Source: APiQypJ/3DH6y3lJq5QBhGCj/quYn/846Af14/JDIMx2bKATqWIcwSSk8+oHxllRL2DjGdyzy6iPkQ==
X-Received: by 2002:adf:fa85:: with SMTP id h5mr1182699wrr.63.1586244831851;
        Tue, 07 Apr 2020 00:33:51 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id g186sm1184915wmg.36.2020.04.07.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:33:50 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:33:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 - v2] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK
 instead.
Message-ID: <20200407071148.GE18914@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
 <87pncqyd7k.fsf@notabene.neil.brown.name>
 <20200402151009.GA14130@infradead.org>
 <87h7y1y0ra.fsf@notabene.neil.brown.name>
 <20200403094220.GA29920@quack2.suse.cz>
 <87k12sw5ws.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k12sw5ws.fsf@notabene.neil.brown.name>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue 07-04-20 09:28:19, Neil Brown wrote:
> On Fri, Apr 03 2020, Jan Kara wrote:
> >
> > So I don't think we can just remove lines from procfs files like this. That
> > has a high potential of breaking some userspace app that is not careful
> > enough when parsing the file. So I think that we need to leave there the
> > format string and just replace K(node_page_state(pgdat, NR_UNSTABLE_NFS))
> > with 0.
> 
> OK.  I assume changing the static trace points isn't a problem though?

It shouldn't be until we learn that somebody depends on it...
-- 
Michal Hocko
SUSE Labs
