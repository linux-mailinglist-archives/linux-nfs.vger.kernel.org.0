Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2B34D490
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhC2QMO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 12:12:14 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.82]:20435 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230362AbhC2QMI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Mar 2021 12:12:08 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C0242C1DF09
        for <linux-nfs@vger.kernel.org>; Mon, 29 Mar 2021 10:51:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id QuAvlwa3MmJLsQuAvlaJWw; Mon, 29 Mar 2021 10:51:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MVjj6c/3EYFRY18LSudOpq9RRJ0gd0CYOhASmpfIFJY=; b=m0YYM27UAhHL2DVQds8D5oVwR1
        iJg/7xmw0OnDIsqTxdkVgUhFTbzvIiLfrG3KRgqMAub8jH78xAHecphLD5g6+4iwz6kIzsYMxkNku
        IeVdQAbfeUiv4mAiTh+3tS8CET3YbFoV/1dnVmv7yztfYGXkEejvjVzEnFaAuFPYtPGWoaBToAClA
        IHa+t3Zn1aXP0Wzi9fjS611XhupwDCiRWpJJ1rZlGJLuywLCO1L0/0BOqX8AI/jlpkFtf2xzTh6qU
        NKDR2n4CWhDZWNEZ6E2UCVVCNh+1M4IyJLJh7ns4rVaG/+4//CFlYHvKl3RWCpZk8OYHEK16ShG7I
        MHb2KRUQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33746 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lQuAv-002LQV-9q; Mon, 29 Mar 2021 10:51:33 -0500
Subject: Re: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
To:     chucklever@gmail.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <20210323224858.GA293698@embeddedor>
 <CAFMMQGtZLNt-jsFFEJVGZaOQyVxckXEGbtan8oDZ-WUNSHkGWg@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <f2333f4b-15ea-cb3e-eea0-d349b469e082@embeddedor.com>
Date:   Mon, 29 Mar 2021 09:51:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFMMQGtZLNt-jsFFEJVGZaOQyVxckXEGbtan8oDZ-WUNSHkGWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lQuAv-002LQV-9q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:33746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/29/21 09:57, Chuck Lever wrote:
> Sorry for the reply via gmail, the original patch did not show up in
> my Oracle mailbox.
> 
> I've been waiting for a resolution of this thread (and perhaps a
> Reviewed-by). But in
> the meantime I've committed this, provisionally, to the for-next topic branch in
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Awesome. :)

Thanks, Chuck.
--
Gustavo

> On Wed, Mar 24, 2021 at 4:39 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> There is a regular need in the kernel to provide a way to declare having
>> a dynamically sized set of trailing elements in a structure. Kernel code
>> should always use “flexible array members”[1] for these cases. The older
>> style of one-element or zero-length arrays should no longer be used[2].
>>
>> Use an anonymous union with a couple of anonymous structs in order to
>> keep userspace unchanged:
>>
>> $ pahole -C nfs_fhbase_new fs/nfsd/nfsfh.o
>> struct nfs_fhbase_new {
>>         union {
>>                 struct {
>>                         __u8       fb_version_aux;       /*     0     1 */
>>                         __u8       fb_auth_type_aux;     /*     1     1 */
>>                         __u8       fb_fsid_type_aux;     /*     2     1 */
>>                         __u8       fb_fileid_type_aux;   /*     3     1 */
>>                         __u32      fb_auth[1];           /*     4     4 */
>>                 };                                       /*     0     8 */
>>                 struct {
>>                         __u8       fb_version;           /*     0     1 */
>>                         __u8       fb_auth_type;         /*     1     1 */
>>                         __u8       fb_fsid_type;         /*     2     1 */
>>                         __u8       fb_fileid_type;       /*     3     1 */
>>                         __u32      fb_auth_flex[0];      /*     4     0 */
>>                 };                                       /*     0     4 */
>>         };                                               /*     0     8 */
>>
>>         /* size: 8, cachelines: 1, members: 1 */
>>         /* last cacheline: 8 bytes */
>> };
>>
>> Also, this helps with the ongoing efforts to enable -Warray-bounds by
>> fixing the following warnings:
>>
>> fs/nfsd/nfsfh.c: In function ‘nfsd_set_fh_dentry’:
>> fs/nfsd/nfsfh.c:191:41: warning: array subscript 1 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>>   191 |        ntohl((__force __be32)fh->fh_fsid[1])));
>>       |                              ~~~~~~~~~~~^~~
>> ./include/linux/kdev_t.h:12:46: note: in definition of macro ‘MKDEV’
>>    12 | #define MKDEV(ma,mi) (((ma) << MINORBITS) | (mi))
>>       |                                              ^~
>> ./include/uapi/linux/byteorder/little_endian.h:40:26: note: in expansion of macro ‘__swab32’
>>    40 | #define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
>>       |                          ^~~~~~~~
>> ./include/linux/byteorder/generic.h:136:21: note: in expansion of macro ‘__be32_to_cpu’
>>   136 | #define ___ntohl(x) __be32_to_cpu(x)
>>       |                     ^~~~~~~~~~~~~
>> ./include/linux/byteorder/generic.h:140:18: note: in expansion of macro ‘___ntohl’
>>   140 | #define ntohl(x) ___ntohl(x)
>>       |                  ^~~~~~~~
>> fs/nfsd/nfsfh.c:191:8: note: in expansion of macro ‘ntohl’
>>   191 |        ntohl((__force __be32)fh->fh_fsid[1])));
>>       |        ^~~~~
>> fs/nfsd/nfsfh.c:192:32: warning: array subscript 2 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>>   192 |    fh->fh_fsid[1] = fh->fh_fsid[2];
>>       |                     ~~~~~~~~~~~^~~
>> fs/nfsd/nfsfh.c:192:15: warning: array subscript 1 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>>   192 |    fh->fh_fsid[1] = fh->fh_fsid[2];
>>       |    ~~~~~~~~~~~^~~
>>
>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/109
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  include/uapi/linux/nfsd/nfsfh.h | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
>> index ff0ca88b1c8f..427294dd56a1 100644
>> --- a/include/uapi/linux/nfsd/nfsfh.h
>> +++ b/include/uapi/linux/nfsd/nfsfh.h
>> @@ -64,13 +64,24 @@ struct nfs_fhbase_old {
>>   *   in include/linux/exportfs.h for currently registered values.
>>   */
>>  struct nfs_fhbase_new {
>> -       __u8            fb_version;     /* == 1, even => nfs_fhbase_old */
>> -       __u8            fb_auth_type;
>> -       __u8            fb_fsid_type;
>> -       __u8            fb_fileid_type;
>> -       __u32           fb_auth[1];
>> -/*     __u32           fb_fsid[0]; floating */
>> -/*     __u32           fb_fileid[0]; floating */
>> +       union {
>> +               struct {
>> +                       __u8            fb_version_aux; /* == 1, even => nfs_fhbase_old */
>> +                       __u8            fb_auth_type_aux;
>> +                       __u8            fb_fsid_type_aux;
>> +                       __u8            fb_fileid_type_aux;
>> +                       __u32           fb_auth[1];
>> +                       /*      __u32           fb_fsid[0]; floating */
>> +                       /*      __u32           fb_fileid[0]; floating */
>> +               };
>> +               struct {
>> +                       __u8            fb_version;     /* == 1, even => nfs_fhbase_old */
>> +                       __u8            fb_auth_type;
>> +                       __u8            fb_fsid_type;
>> +                       __u8            fb_fileid_type;
>> +                       __u32           fb_auth_flex[]; /* flexible-array member */
>> +               };
>> +       };
>>  };
>>
>>  struct knfsd_fh {
>> @@ -97,7 +108,7 @@ struct knfsd_fh {
>>  #define        fh_fsid_type            fh_base.fh_new.fb_fsid_type
>>  #define        fh_auth_type            fh_base.fh_new.fb_auth_type
>>  #define        fh_fileid_type          fh_base.fh_new.fb_fileid_type
>> -#define        fh_fsid                 fh_base.fh_new.fb_auth
>> +#define        fh_fsid                 fh_base.fh_new.fb_auth_flex
>>
>>  /* Do not use, provided for userspace compatiblity. */
>>  #define        fh_auth                 fh_base.fh_new.fb_auth
>> --
>> 2.27.0
>>
> 
> 
