Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029A793898
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 11:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjIFJnd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbjIFJnc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 05:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4D1721
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693993362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVp7a7K3f5Dla3U4bqJQu6oFrZiBEOge2h0GYL+p8bs=;
        b=QMpNe1go8Sq2BHydG7LwHR3gEvlRpNRQE+As0UAE4LO1JS9fTIDFIGxQAXRViYaO3ZYlB2
        B+X45XWqZw2uNPo0Ksle308694wViNtnWlCtPeodcp/HU1nqeZOTxAlSprJ16VzkIAiGAo
        jai19ym1Nrt5dtzyB++1+9HeCOXOgS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-IR4_4bF1NjG4eDTr2UyRnQ-1; Wed, 06 Sep 2023 05:42:37 -0400
X-MC-Unique: IR4_4bF1NjG4eDTr2UyRnQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401c19fc097so21384125e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Sep 2023 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993356; x=1694598156;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVp7a7K3f5Dla3U4bqJQu6oFrZiBEOge2h0GYL+p8bs=;
        b=ekwBuhu3YSeA8L6UjbGy34RWbTdV7zlfx8sSpg0mqPiXyOWUEObf7VCDtmZjG1MICE
         z2DslIUH92TvXJWBJb7AoQzUswAXpQ8Go+Y83jhk+Vna8D0JjumTj0/aIsoAVQtf8Y+9
         8QDZon/fxZNyvKLykMAMVRR6R487mdgqxtTIm8f2NSnr3Fsh0vsO5KzjF/ipW8zRGuvN
         yDg6kl5ogJtAfP4MKiXU5BzjdNz4zCj7mivdnHbFppTLfB18FHNHFxox7dNF5kaumQZw
         PRyXJw/3s4yYULg4GeYCJrmcHH4hcETiJypx61HeqTg5h75AZrr4E5xL1GbNz+3g3dWc
         KK/A==
X-Gm-Message-State: AOJu0Yx/bihYBjXGve8EHVt8mCx8dc1/ZmoaKnO3lEvY3gBvaLrYMHaL
        +ynbzYpOI0JKFrqlz2RsnWPn4hlV9qoveapztcnQUlz8vF7a6XnRjKME9RNbZXIvybR3GS+RywD
        a28c7uFbU774q84GvEX3x
X-Received: by 2002:a7b:c457:0:b0:3fe:238e:b23b with SMTP id l23-20020a7bc457000000b003fe238eb23bmr1759230wmi.36.1693993355956;
        Wed, 06 Sep 2023 02:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm59ghFt9D38dbkF6LH1whBObd7ER9cWes//aSpkd/gk6Lh0jZNpZxRdXykeg2PgJmqp9G1w==
X-Received: by 2002:a7b:c457:0:b0:3fe:238e:b23b with SMTP id l23-20020a7bc457000000b003fe238eb23bmr1759213wmi.36.1693993355580;
        Wed, 06 Sep 2023 02:42:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b003fee6e170f9sm19270240wmb.45.2023.09.06.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:42:35 -0700 (PDT)
Message-ID: <0240468f-3cc5-157b-9b10-f0cd7979daf0@redhat.com>
Date:   Wed, 6 Sep 2023 11:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
References: <20230905141604.GA27370@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: getting rid of the last memory modifitions through gup(FOLL_GET)
In-Reply-To: <20230905141604.GA27370@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 05.09.23 16:16, Christoph Hellwig wrote:
> Hi all,

Hi,

> 
> we've made some nice progress on converting code that modifies user
> memory to the pin_user_pages interface, especially though the work
> from David Howells on iov_iter_extract_pages.  This thread tries to
> coordinate on how to finish off this work.
> 
> The obvious next step is the remaining users of iov_iter_get_pages2
> and iov_iter_get_pages_alloc2.  We have three file system direct I/O
> users of those left: ceph, fuse and nfs.  Lei Huang has sent patches
> to convert fuse to iov_iter_extract_pages which I'd love to see merged,
> and we'd need equivalent work for ceph and nfs.
> 
> The non-file system uses are in the vmsplice code, which only reads

vmsplice really has to be fixed to specify FOLL_PIN|FOLL_LONGTERM for 
good; I recall that David Howells had patches for that at one point. (at 
least to use FOLL_PIN)

> from the pages (but would still benefit from an iov_iter_extract_pages
> conversion), and in net.  Out of the users in net, all but the 9p code
> appear to be for reads from memory, so they don't pin even if a
> conversion would be nice to retire iov_iter_get_pages* APIs.
> 
> After that we might have to do an audit of the raw get_user_pages APIs,
> but there probably aren't many that modify file backed memory.

ptrace should apply that ends up doing a FOLL_GET|FOLL_WRITE.

Further, KVM ends up using FOLL_GET|FOLL_WRITE to populate the 
second-level page tables for VMs, and uses MMU notifiers to synchronize 
the second-level page tables with process page table changes. So once a 
PTE goes from writable -> r/o in the process page table, the second 
level page tables for the VM will get updated. Such MMU users are quite 
different from ordinary GUP users.

Converting the latter to FOLL_PIN is not desired (as it would implicitly 
  trigger COW-unsharing on KSM pages -- but GUP+MMU notifiers is 
different to ordinary GUP+read/write where there is no such 
synchronization).

Converting ptrace might not be desired/required as well (the reference 
is dropped immediately after the read/write access).

The end goal as discussed a couple of times would be the to limit 
FOLL_GET in general only to a couple of users that can be audited and 
keep using it for a good reason. Arbitrary drivers that perform DMA 
should stop using it (and ideally be prevented from using it) and switch 
to FOLL_PIN.

-- 
Cheers,

David / dhildenb

