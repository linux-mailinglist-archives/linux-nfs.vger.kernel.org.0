Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB16FC64E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 May 2023 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjEIM1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjEIM1l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 08:27:41 -0400
X-Greylist: delayed 689 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 05:27:34 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7AC13D;
        Tue,  9 May 2023 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oyet.no;
        s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wPzLnYkfgYG9VxeE2jywpzLYAmGs2YufgheytGnaHgc=; b=SoKPh/XYmHuUFB1mOvOrH7BAYh
        kU4R0cV1L84ZEnwYGNAUbvVpDtMsRgd/rSJw6LPC5HlLnxr/I3xWumobk5tPl7LfuETTh9cdsx6l6
        chQQ2uvtfrQFIi7gQzzaJYIds7umkrmigRXQ0ZzBHUtLRvClG7OH9cjnhkA7urQIo9JouOHn1r4SZ
        YQ6M9gasPBVjXPPJ0SY7SBKKRVqAKoaN3J6HY2/+4YnPkUkMB+lk2RFkEfCrBupgqvE/gJyxUoXg+
        CaDCeaa6f8DIRQIHlMQ8tNph9Yy1LDHLrCxu7qRUF82ZUH+fUYtzkrdHTT+9bT8prOUkSSwGkmzzt
        izYBkSsA==;
Received: from [194.63.254.34] (port=57321 helo=[172.16.161.129])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <jan-lnfs@oyet.no>)
        id 1pwLuF-000kFr-8t;
        Tue, 09 May 2023 13:53:23 +0200
Message-ID: <1d5d8438-e1df-35cb-ed53-8a91ad8d8811@oyet.no>
Date:   Tue, 9 May 2023 13:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] NFS: Add mount option 'nofasc'
Content-Language: en-US
To:     Chengen Du <chengen.du@canonical.com>,
        trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230411030248.53356-1-chengen.du@canonical.com>
 <CAPt2mGNqqDeRMeCSVh6oX_=nS0UcGCfhBfVcuaVG9HpdwVSzVg@mail.gmail.com>
 <CAPza5qee7vHKwjwhS27xB8xXTgAFHEmv7eiFk6zGTUUc4s8=TQ@mail.gmail.com>
 <CAPza5qcz_-zSJ0AQkq6tnhYvY7Gs+qAnDoaqiH67zgWhjAtAkA@mail.gmail.com>
From:   Jan Ingvoldstad <jan-lnfs@oyet.no>
In-Reply-To: <CAPza5qcz_-zSJ0AQkq6tnhYvY7Gs+qAnDoaqiH67zgWhjAtAkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

The issues causing inconvenience could be easily resolved by 
Canonical/Ubuntu without involving this upstream list, but they are of 
concern for anyone trying to track non-stable Linux kernel releases as well.


May I be so bold as to suggest that the feature in question be reversed 
to an opt-in instead of an opt-out?


As an option "fasc" for having these features enabled, with "nofasc" the 
default.


By making it opt-out, as suggested, or keeping the current patches in 
place, there is around a 50-100 fold resource requirement on the NFS 
server, which makes the Linux versions using these patches (from 6.2-rc3 
onwards) completely unsuitable for NFS clients in a multi-user 
client-server environment.


It amazes me that this keeps going on without resolution for well over 
two months now, and I request that this matter is bumped in priority.


Cheers,

Jan


Den 09.05.2023 04:31, skrev Chengen Du:
> Hi Trond,
>
> I sincerely apologize for interrupting you, as I understand that you
> may have other pressing matters to attend to.
> However, I was hoping to bring your attention to a pressing matter
> that a number of community users are currently experiencing.
> As can be seen in this link:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015827,
> the issue at hand is causing a significant amount of inconvenience to
> many individuals.
>
> If it wouldn't be too much trouble, I would be immensely grateful if
> you could spare a moment to examine the patch and perhaps offer some
> guidance on how best to proceed.
> Your assistance in this matter would be greatly appreciated.
>
> Best regards,
> Chengen Du
>
> On Tue, Apr 25, 2023 at 9:41 AM Chengen Du <chengen.du@canonical.com> wrote:
>> Hi,
>>
>> May I ask if there are any concerns or opinions regarding the
>> introduction of the new mount option?
>> If there is a more suitable solution, we can discuss it, and I can
>> work on implementing it.
>>
>> Best regards,
>> Chengen Du
>>
>> On Wed, Apr 19, 2023 at 3:18 PM Daire Byrne <daire@dneg.com> wrote:
>>> Just to say, I am personally for this or some other way to opt out of
>>> the increased ACCESS calls on select servers (e.g. ones with high
>>> latency or with lots of multi user logins).
>>>
>>> I see it as similar to "actimeo" and "nocto" options in allowing users
>>> to reduce "correctness" at their own risk if it helps with their
>>> workloads and they deem the risk worth it.
>>>
>>> I am currently reverting the original patches in our kernel for our
>>> nfs re-exporting workloads.
>>>
>>> Daire
>>>
>>>
>>> On Tue, 11 Apr 2023 at 04:03, Chengen Du <chengen.du@canonical.com> wrote:
>>>> This mount option is used to skip clearing the file access cache
>>>> upon login. Some users or applications switch to other privileged
>>>> users via commands such as 'su' to operate on NFS-mounted folders.
>>>> In such cases, the privileged user's login time will be renewed,
>>>> and NFS ACCESS operations will need to be re-sent, potentially
>>>> leading to performance degradation.
>>>> In some production environments where the access cache can be
>>>> trusted due to stable group membership, this option could be
>>>> particularly useful.
>>>>
>>>> Signed-off-by: Chengen Du <chengen.du@canonical.com>
>>>> ---
>>>>   fs/nfs/dir.c              | 21 ++++++++++++---------
>>>>   fs/nfs/fs_context.c       |  8 ++++++++
>>>>   fs/nfs/super.c            |  1 +
>>>>   include/linux/nfs_fs_sb.h |  1 +
>>>>   4 files changed, 22 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>>> index 6fbcbb8d6587..9a6d86e2044e 100644
>>>> --- a/fs/nfs/dir.c
>>>> +++ b/fs/nfs/dir.c
>>>> @@ -2953,12 +2953,14 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
>>>>          return NULL;
>>>>   }
>>>>
>>>> -static u64 nfs_access_login_time(const struct task_struct *task,
>>>> -                                const struct cred *cred)
>>>> +static inline
>>>> +bool nfs_check_access_stale(const struct task_struct *task,
>>>> +                           const struct cred *cred,
>>>> +                           const struct nfs_access_entry *cache)
>>>>   {
>>>>          const struct task_struct *parent;
>>>>          const struct cred *pcred;
>>>> -       u64 ret;
>>>> +       u64 login_time;
>>>>
>>>>          rcu_read_lock();
>>>>          for (;;) {
>>>> @@ -2968,15 +2970,15 @@ static u64 nfs_access_login_time(const struct task_struct *task,
>>>>                          break;
>>>>                  task = parent;
>>>>          }
>>>> -       ret = task->start_time;
>>>> +       login_time = task->start_time;
>>>>          rcu_read_unlock();
>>>> -       return ret;
>>>> +
>>>> +       return ((s64)(login_time - cache->timestamp) > 0);
>>>>   }
>>>>
>>>>   static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, u32 *mask, bool may_block)
>>>>   {
>>>>          struct nfs_inode *nfsi = NFS_I(inode);
>>>> -       u64 login_time = nfs_access_login_time(current, cred);
>>>>          struct nfs_access_entry *cache;
>>>>          bool retry = true;
>>>>          int err;
>>>> @@ -3005,7 +3007,8 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
>>>>                  retry = false;
>>>>          }
>>>>          err = -ENOENT;
>>>> -       if ((s64)(login_time - cache->timestamp) > 0)
>>>> +       if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
>>>> +           nfs_check_access_stale(current, cred, cache))
>>>>                  goto out;
>>>>          *mask = cache->mask;
>>>>          list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
>>>> @@ -3025,7 +3028,6 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>>>>           * but do it without locking.
>>>>           */
>>>>          struct nfs_inode *nfsi = NFS_I(inode);
>>>> -       u64 login_time = nfs_access_login_time(current, cred);
>>>>          struct nfs_access_entry *cache;
>>>>          int err = -ECHILD;
>>>>          struct list_head *lh;
>>>> @@ -3040,7 +3042,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>>>>                  cache = NULL;
>>>>          if (cache == NULL)
>>>>                  goto out;
>>>> -       if ((s64)(login_time - cache->timestamp) > 0)
>>>> +       if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
>>>> +           nfs_check_access_stale(current, cred, cache))
>>>>                  goto out;
>>>>          if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
>>>>                  goto out;
>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>>> index 9bcd53d5c7d4..5cd9b2882c79 100644
>>>> --- a/fs/nfs/fs_context.c
>>>> +++ b/fs/nfs/fs_context.c
>>>> @@ -88,6 +88,7 @@ enum nfs_param {
>>>>          Opt_vers,
>>>>          Opt_wsize,
>>>>          Opt_write,
>>>> +       Opt_fasc,
>>>>   };
>>>>
>>>>   enum {
>>>> @@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>>>>          fsparam_string("vers",          Opt_vers),
>>>>          fsparam_enum  ("write",         Opt_write, nfs_param_enums_write),
>>>>          fsparam_u32   ("wsize",         Opt_wsize),
>>>> +       fsparam_flag_no("fasc",         Opt_fasc),
>>>>          {}
>>>>   };
>>>>
>>>> @@ -861,6 +863,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>>>>          case Opt_sloppy:
>>>>                  ctx->sloppy = true;
>>>>                  break;
>>>> +       case Opt_fasc:
>>>> +               if (result.negated)
>>>> +                       ctx->flags |= NFS_MOUNT_NOFASC;
>>>> +               else
>>>> +                       ctx->flags &= ~NFS_MOUNT_NOFASC;
>>>> +               break;
>>>>          }
>>>>
>>>>          return 0;
>>>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
>>>> index 05ae23657527..059513d403f8 100644
>>>> --- a/fs/nfs/super.c
>>>> +++ b/fs/nfs/super.c
>>>> @@ -444,6 +444,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
>>>>                  { NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
>>>>                  { NFS_MOUNT_UNSHARED, ",nosharecache", "" },
>>>>                  { NFS_MOUNT_NORESVPORT, ",noresvport", "" },
>>>> +               { NFS_MOUNT_NOFASC, ",nofasc", "" },
>>>>                  { 0, NULL, NULL }
>>>>          };
>>>>          const struct proc_nfs_info *nfs_infop;
>>>> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
>>>> index ea2f7e6b1b0b..a39ae1bd2217 100644
>>>> --- a/include/linux/nfs_fs_sb.h
>>>> +++ b/include/linux/nfs_fs_sb.h
>>>> @@ -153,6 +153,7 @@ struct nfs_server {
>>>>   #define NFS_MOUNT_WRITE_EAGER          0x01000000
>>>>   #define NFS_MOUNT_WRITE_WAIT           0x02000000
>>>>   #define NFS_MOUNT_TRUNK_DISCOVERY      0x04000000
>>>> +#define NFS_MOUNT_NOFASC               0x08000000
>>>>
>>>>          unsigned int            fattr_valid;    /* Valid attributes */
>>>>          unsigned int            caps;           /* server capabilities */
>>>> --
>>>> 2.37.2
>>>>
-- 
Cheers,
Jan

