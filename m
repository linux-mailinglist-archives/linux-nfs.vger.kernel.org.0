Return-Path: <linux-nfs+bounces-19472-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCE4BzpPpGkPdQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19472-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 15:37:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5E1D03BB
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECB313006996
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39FC1F5847;
	Sun,  1 Mar 2026 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV0yiL5r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2672765F5
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772375857; cv=pass; b=i6OHXygOs6PgWcKijfzbBDq+i1FMW0E780xdm2CB2D9z+H8sRf6gX6HLI1760UhMmd99opvq5p2v4WxaumrEPW+yqUuQ/Yb/ERkanVRK82iTl6KGo5aTsKTxNf7SpObGRy5zqghZMZjHwj4TYy+HCh9cf67APT67OwejNDaRj6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772375857; c=relaxed/simple;
	bh=625gZNnRxZIFUziWnhyJIyHHkF1YBFCE+gLuVfaoUbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2xOTomPV68wywoHOI8Zf4rZuo8nrMuD7g31EfE/tVqL9Ie+Toe/djjB1PJbB76oimpBuoYG3l+43deuZSrpH6ItRC4QGQ/vIRftok/oAzpZ3ShwYHFxMj/PtnIgA8hF6EgICTQ/hoaglet4UKNboLwiYhL5xT6W72HkFgkWPdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV0yiL5r; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8fa449e618so512872766b.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 06:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772375854; cv=none;
        d=google.com; s=arc-20240605;
        b=SNcjoyYhZWjFMhhHVLcR8wEiUIDzH0kg/+6HL8ZnjkU2xm3RpqcAzxJDsIW7ng5r6Z
         pIAwnOmZZ2+aQA2cO6wx7faeANIOPxsqnbHhOfAguzBcvxv4EKTnskK1CWlYxtH/5op7
         vyt2HHxVw0h4KuJ4UuvyMYnmlI450nWFzoZqJlp1T4XU5b/vzTlF75q+aCMpwb2aguCg
         Ft/XoNyXIxPAkJeNcS9+wDqjzjpqP0SXzLTMgYe1UXNRvJwXGW6MORTwmF+OJ0zRcx6o
         DGdL1THO02QdAMiapOkGBhM1bNDQoRKQ2IdItTxwN4VWIh1sHRKW2aPezmofEj/6iMhb
         rn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ygkpdtgYt43wLbKzCQcb7cO94CFKVbX0lUDx+zyuuvA=;
        fh=JE/crsjZZ7kWgH4d3f8HwgjniSUWwHS8bgPGaM9EWLM=;
        b=Jt0wf3BNa1ggKiGHH+Y/POWuevKgUmoZRz/GyBa/Pm/xdrvg27DeL8l9UGC7a0rPmC
         ZZItP3gcplAc+gm7L5jeGSoAjsddaleesee0n3SMP/RkAVk1q913swi63DMeB5Mqoq/3
         ob5Gy7Gd2rSKuX69ptfCTNw5uyenJ8yIZLIYxSi+hnLfe5bBczCkazNL4iyHmu9x32gO
         SM8quvmw9TChxXkFxht4oHrCWyzmQHXnhlOUOm4OP1/M2e3l0jeG8SFcB6fq+mPkjt1a
         ynRhZ7IKKUG5c0qwWgLaLkzHr0MxhugKKTICtgsz5fySJ4fK6X9tckLX+NVucOMbIEHK
         0rFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772375854; x=1772980654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygkpdtgYt43wLbKzCQcb7cO94CFKVbX0lUDx+zyuuvA=;
        b=WV0yiL5r/66xXtglTQp7GDHZ8zbwFvXRSrpnwdQ1iE1asnO0Lv874s0Emh3OL3WUOt
         TGqbWPEWCtvaX2IQcRf+PrZ5C7Nt0veyvy6iO8kbKi0svgzrV2nsWNAUpZs2eiOp/Z+z
         D+Jhwi1yy10AYHNPTdgA0CPfSYDRsSy3r1FXP603xyVXuWvJO68YCNZCLewa7QMOwreX
         hVgberXZhXScHw/6UW6P7qadXLeJ/rsOMLfYDob4HDeXcll+zn57G4EyqNYMYgwy5V45
         oNF2VH1laL5IvRCQR03z/JVAsimAV8Hcs1fVr3M7YfIwC+XfHFPY6IIat6wkHxe7G+f6
         FL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772375854; x=1772980654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygkpdtgYt43wLbKzCQcb7cO94CFKVbX0lUDx+zyuuvA=;
        b=bnuclIUs8jiKyepjCop/tQyFVDwwTPXfNOqNMaAgbgdyOnV+cW5H6mHr7E08E60zDP
         HgCV8Izt6QNOhmS3k4e9wxv5AgvA1nhi5Kjc5oKRgV+sRO2dwS6NHOb2LOd0XkswtgM6
         xCERcvxHGfmlG//u6gakcCR11s02yNJ1KlMjpss3BgKJ1nbJqHWdOqBPkv/EcXqf/u+G
         gKlUqll0VGVaAgRjZfLxemNklUT7eZ5ueYonvePgWMwirWLh4MqsIh46iMEscGOqe3FV
         dCE7Yz0AtlQp8sTQtblEckJwJJK6YNX3BUrhHRTYzmEf4i9wgUubrK2BOYHKOLNK+Jx9
         ZBVw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqjDyo080/B9Rn/1ZeUz0eQN16UYQ59RrwV05uHVcdmrIAc2N+U5DA5Wf29DeSPrs6nCxnqjnKA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUGVN4sabIM2h1teu09Uae9tMKpE9BT0qHMOa64fTVfHPxWOF
	9HXE2ydnNJ8GKA3E0SrBs87YJBEJGvgPwqlBeq0httCPYIaJn6yIguyfbi0QpgZK8/Kc5qrKl+Z
	H/zuWP4uhlFE+fsxqK7YUcg9yFIKIsu8=
X-Gm-Gg: ATEYQzwJvqBkSKTAIPT9+lWvFV6GCSa1SVnRW0sWgSWgwNYbUhQyG9W1gEF24NKZ91B
	wPz901BNLWn872gNYyUqi5yFmREpzgBsNv/P/xYsvBHRyjR8Rnyl1geB6Of4fVMc9DlZuCwGRge
	2cAltb4bVA080tdWoofoJg7Uw34u9+OwIYuDFrCLpE7JxDJnYd+qudRam1g/GA9vCf73ta8Pl8b
	XjO+NKfs/62TgE/V7Sa+HT8mPlhbul94ZOFgLeTqOa9oneitM7Ud/PGc45Sd8l+g+rr2t/YZvrj
	KEXu5Dg+y+/qN+BYdRUepFq/AndSBTsQXvs0Ma7HKQ==
X-Received: by 2002:a17:907:72d3:b0:b8e:d260:cb32 with SMTP id
 a640c23a62f3a-b937636251amr594760166b.1.1772375853311; Sun, 01 Mar 2026
 06:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224163908.44060-1-cel@kernel.org> <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner> <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org> <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
In-Reply-To: <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Mar 2026 15:37:22 +0100
X-Gm-Features: AaiRm512SKV0wxOihBEzE38zQxTfytsYOSFftGIB6yHszI6KOOrNArgilOtkWq0
Message-ID: <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19472-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,suse.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08F5E1D03BB
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 2/26/26 8:32 AM, Jan Kara wrote:
> > On Thu 26-02-26 08:27:00, Chuck Lever wrote:
> >> On 2/26/26 5:52 AM, Amir Goldstein wrote:
> >>> On Thu, Feb 26, 2026 at 9:48=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>> Another thing: These ad-hoc notifiers are horrific. So I'm pitching
> >>>> another idea and I hope that Jan and Amir can tell me that this is
> >>>> doable...
> >>>>
> >>>> Can we extend fsnotify so that it's possible for a filesystem to
> >>>> register "internal watches" on relevant objects such as mounts and
> >>>> superblocks and get notified and execute blocking stuff if needed.
> >>>>
> >>>
> >>> You mean like nfsd_file_fsnotify_group? ;)
> >>>
> >>>> Then we don't have to add another set of custom notification mechani=
sms
> >>>> but have it available in a single subsystem and uniformely available=
.
> >>>>
> >>>
> >>> I don't see a problem with nfsd registering for FS_UNMOUNT
> >>> event on sb (once we add it).
> >>>
> >>> As a matter of fact, I think that nfsd can already add an inode
> >>> mark on the export root path for FS_UNMOUNT event.
> >>
> >> There isn't much required here aside from getting a synchronous notice
> >> that the final file system unmount is going on. I'm happy to try
> >> whatever mechanism VFS maintainers are most comfortable with.
> >
> > Yeah, then as Amir writes placing a mark with FS_UNMOUNT event on the
> > export root path and handling the event in
> > nfsd_file_fsnotify_handle_event() should do what you need?
>
> Turns out FS_UNMOUNT doesn't do what I need.
>
> 1/3 here has a fatal flaw: the SRCU notifier does not fire until all
> files on the mount are closed. The problem is that NFSD holds files
> open when there is outstanding NFSv4 state. So the SRCU notifier will
> never fire, on umount, to release that state.
>
> FS_UNMOUNT notifiers have the same issue.
>
> They fire from fsnotify_sb_delete() inside generic_shutdown_super(),
> which runs inside deactivate_locked_super(), which runs when s_active
> drops to 0. That requires all mounts to be freed, which requires all
> NFSD files to be closed: the same problem.
>
> For any notification approach to actually do what is needed, it needs to
> fire during do_umount(), before propagate_mount_busy(). Something like:
>
> do_umount(mnt):
>     <- NEW: notify subsystems, allow them to release file refs
>     retval =3D propagate_mount_busy(mnt, 2)   // now passes
>     umount_tree(mnt, ...)
>
> This is what Christian's "internal watches... execute blocking stuff"
> would need to enable. The existing fsnotify plumbing (groups, marks,
> event dispatch) provides the infrastructure, but a new notification hook
> in do_umount() is required =E2=80=94 neither fsnotify_vfsmount_delete() n=
or
> fsnotify_sb_delete() fires early enough.
>
> But a hook in do_umount() fires for every mount namespace teardown, not
> just admin-initiated unmounts. NFSD's callback would need to filter
> (e.g., only act when it's the last mount of a superblock that NFSD is
> exporting).
>
> This is why I originally went with fs_pin. Not saying the series should
> go back to that, but this is the basic requirement: NFSD needs
> notification of a umount request while files are still open on that
> mount, so that it can revoke the NFSv4 state and close those files.
>

I understand the problem with FS_UNMOUNT, but I fail to understand
the desired semantics, specifically the "the last mount of a superblock
that NFSD is exporting".

One option is that nfsd will use a private mount clone for accessing
files as overlayfs does and wait until all the other mounts are gone,
but FWIW that has some user visible implications.

Then we can enable subscribing for FS_MNT_DETACH events on a
super_block.
fanotify UAPI currently only allows subscribing them on mntns,
but allowing internal users to subscribe on all the unmounts of a sb
should be as simple as below (famous last word).

Thanks,
Amir.


diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e59..0abe16db3636c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -695,6 +695,7 @@ void fsnotify_mnt(__u32 mask, struct mnt_namespace
*ns, struct vfsmount *mnt)
 {
        struct fsnotify_mnt data =3D {
                .ns =3D ns,
+               .sb =3D mnt->mnt_sb,
                .mnt_id =3D real_mount(mnt)->mnt_id_unique,
        };

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_back=
end.h
index 95985400d3d8e..c21fae333f0dc 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -332,6 +332,7 @@ static inline const struct path
*file_range_path(const struct file_range *range)

 struct fsnotify_mnt {
        const struct mnt_namespace *ns;
+       struct super_block *sb;
        u64 mnt_id;
 };

@@ -395,6 +396,8 @@ static inline struct super_block
*fsnotify_data_sb(const void *data,
                return file_range_path(data)->dentry->d_sb;
        case FSNOTIFY_EVENT_ERROR:
                return ((struct fs_error_report *) data)->sb;
+       case FSNOTIFY_EVENT_MNT:
+               return ((struct fsnotify_mnt *)data)->sb;
        default:
                return NULL;
        }

