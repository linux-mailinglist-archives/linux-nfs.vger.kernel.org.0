Return-Path: <linux-nfs+bounces-19894-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLD6EjYDr2lmLgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19894-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 18:28:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876123DA45
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 18:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 786D7300468D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66AE28D8F1;
	Mon,  9 Mar 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJAhNFL4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0866285072
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077295; cv=none; b=UXqsHayqyovLUAgGnLSZrRD22v9LGGrEzfPXeTDDaEW4TGYVg9W4dAkOGk+FbfHL4dW6L7dbwW2kZNbXOPZp6EDBV8o8SxLMJyYfUf8RhH/5K0O7ERAPO67VmGK7qCUE24ELKyu0UeEsqZEs9HEKpfhSi1RzZ2isedCxZy+JjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077295; c=relaxed/simple;
	bh=LcKBSGkUJ4jOZjfNY8MJfZV+UOABBnNyslHE4iTDcoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjrR6HAwXdMKSEbRLPEmaOmgNF4R8sQp0dYeX3gjR18VHIbuFHMoSdcnEb1hTfxex+VtWZVtdPKDaqu5ildBAXqUezruaW7Qmx65WDqk7mbMMLvd48LJ8YYpca+v7oQta4UfWw0NEvKgLxXtq9NwcQrocn2u22txxrtW5/jYpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJAhNFL4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-662b42ca100so436539a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773077292; x=1773682092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/0fgmHhC0VOep6ZWbqzX4YfecogO4RJ08oTSaCn8/k=;
        b=cJAhNFL40G8kzdRZgXxrLMB88fi8JknQWEEtg1ioErR+4FQmVRgyimT8wv8uIZjeGc
         q3X1WUv4m1IZ+erl4QYqfinFW9Lbxr89V78/OkICej6YvZlO3un5FeaLCZM45I/ZN1Ae
         oIffHCg9PeEkC0pZ+GR24OgELXFFny++sfnwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077292; x=1773682092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/0fgmHhC0VOep6ZWbqzX4YfecogO4RJ08oTSaCn8/k=;
        b=tagcQJupKJf60V0aZ21eEgzGkVb8Hvo/rVwpCd3wmjWEMtV+XX/1pt+3H+9i8tA4uh
         Y/m9cXJaNxkZCxjtRPkiB8Vx3w6C0FkIuM8Iskfmg15I1Ds2QzeeJ1fqE0x7CoPUW97g
         HPN+YnsNoGj3GBkScyHu2/EjAnJdPa5BgXjKz7cbd8hafkQJ5LT4hHeAbpXQMPjLQqcI
         xuSbmifh2zdbZ/9wiSXpZqZ+9egURuYb/KnG4ZSt4wbsH2ESPA/i3CvZuGESJasQ3rBc
         9fJT4h96MLMTuvWyOFMOFyh2vsIPeTIGEs0Qce9cV7SBSiym8NqAtlIuK8AIIjPxTOxf
         WRIg==
X-Forwarded-Encrypted: i=1; AJvYcCWTnOyAAI2PRcGf5FqBHYSyNjXA+WuzTqKxV/3erhgplvG4mPJFwAgY1hsl9SI3ANTpYOEFQvqLVvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ohh64CgAVN4xcnLOKIxjzmHPTDP/J+4BqsQ+fnXuL1Ba9aMM
	LAsQ0NDXo8k0Fw3whGgI5toEHr/Ga/LCuKJapmr5LOcYvYi9i8jLeKdFfQd3zXDpJ+sGcgdiKUs
	qCULc76A=
X-Gm-Gg: ATEYQzx0hgDM+5q7ejt2Pl4EskQfyrsOsl2OqbA37chAKmbXjINwuL1U7pSGKZVI9AX
	cl5cIFISLf9ZJwaR9gbjGbORgng91su3RnAS1+lvnxUdPTLkWj+EiM1a3IpZbtbV88jnTV0L+sL
	qLEv/MVYddaNag/7y7AgROhy9WfeLQGD6BwZ/bdHGHYUi1gQgwwO/SVH1Kz4QDfCOSAf2z63IFm
	V+9RMi2ruW6WEDoJuFiLv3kZ71vdwWz5Ra7pBX0WjOdRde9Jk3+5z2TixGPE5ffhEbRWGmVp7Fk
	PgTWj2wcuM45SPu1ctg+i/9TBhM+1utppIy6K4oLsqbD4RyAHj5RfXZKdZSQq/O2fNl6bd3bUsm
	4vpAZhkP6GU6F+Hrc9vr3C9aoVjNk8LBwNy2+Fx811cRCZB5wgEmLbVNbjgNkYtKf+xLrD0QooD
	SJ1pkUZqcGHBaqoGG0iGdBhxICEjqT1BEo/Dk8TLlHNjmCA7H2WQlzkJUvp4Sf8hlUIytPC0Sn
X-Received: by 2002:a17:907:d12:b0:b94:898:7bd2 with SMTP id a640c23a62f3a-b942df754fcmr682494566b.39.1773077291991;
        Mon, 09 Mar 2026 10:28:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef48267sm398808266b.3.2026.03.09.10.28.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:28:10 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-662b42ca100so436457a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 10:28:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoU39fI3GQm4MV7NAAMd4VddW6kw372ZlMR0DoNkThxrk2rdZxKRB4c40X5r0SbwwyMsLVtcdMnuU=@vger.kernel.org
X-Received: by 2002:a05:6402:50d4:b0:65c:23f0:a80d with SMTP id
 4fb4d7f45d1cf-6619d4e3738mr5814793a12.19.1773077289768; Mon, 09 Mar 2026
 10:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org> <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org> <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
In-Reply-To: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2026 10:27:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-QpnBHMH4Oa6tsYVhp+Uv+hKU_oedAUnt4icMqwPtzQ@mail.gmail.com>
X-Gm-Features: AaiRm50OcoxR7YXKVzqClnrYq6PJcpS66d_jgF8-UVsQY5IDs7VWWvYFcU4JSa0
Message-ID: <CAHk-=wi-QpnBHMH4Oa6tsYVhp+Uv+hKU_oedAUnt4icMqwPtzQ@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: multipart/mixed; boundary="0000000000000491e3064c9abac4"
X-Rspamd-Queue-Id: 6876123DA45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19894-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,googlegroups.com,suse.com,google.com,atomlin.com,oracle.com,brown.name,redhat.com,talpey.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-nfs@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,linux-foundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Action: no action

--0000000000000491e3064c9abac4
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 09:37, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, there are real exports in this area that are actually strange and
> should be removed: for some historical reason we export 'free_task()'
> which makes no sense to me at all (but probably did at some point).
>
> Now *that* is a strange export that can mess up another task in major ways.
>
> [ Ok, I was intrigued and I went and dug into history: we used to do
> it in the oprofile driver many many moons ago. ]

It looks like it should not only no longer be exported, it should
actually be static to kernel/fork.c. As far as I can tell, that
historic oprofile use was the only reason ever this was exposed in any
way.

IOW, a patch like the attached is probably a good idea.

Somebody should probably remind me next merge window (I'm not going to
make 7.0 bigger, and I find examples of people using
kretprobe/free_task, which *should* still work just fine with a static
function, but for all I know if the compiler inlines things it will
cause issues).

Or just add this patch to one of the trees scheduled for next merge
window. I'm not currently carrying a linux-next branch (I actively
deleted it because it caused problems due to messing up other peoples
linux-next branches, so if I ever introduce one I will have to come up
with a better name anyway)

                  Linus

--0000000000000491e3064c9abac4
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mmjgdgcc0>
X-Attachment-Id: f_mmjgdgcc0

IGluY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oIHwgMiAtLQoga2VybmVsL2ZvcmsuYyAgICAgICAg
ICAgICAgfCAzICstLQogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaCBiL2luY2x1ZGUv
bGludXgvc2NoZWQvdGFzay5oCmluZGV4IDQxZWQ4ODRjZmZjOS4uMGVkYjM2MTA3YWM1IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaAorKysgYi9pbmNsdWRlL2xpbnV4L3Nj
aGVkL3Rhc2suaApAQCAtMTA2LDggKzEwNiw2IEBAIGV4dGVybiBwaWRfdCB1c2VyX21vZGVfdGhy
ZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpCiBl
eHRlcm4gbG9uZyBrZXJuZWxfd2FpdDQocGlkX3QsIGludCBfX3VzZXIgKiwgaW50LCBzdHJ1Y3Qg
cnVzYWdlICopOwogaW50IGtlcm5lbF93YWl0KHBpZF90IHBpZCwgaW50ICpzdGF0KTsKIAotZXh0
ZXJuIHZvaWQgZnJlZV90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKTsKLQogLyogc2NoZWRf
ZXhlYyBpcyBjYWxsZWQgYnkgcHJvY2Vzc2VzIHBlcmZvcm1pbmcgYW4gZXhlYyAqLwogZXh0ZXJu
IHZvaWQgc2NoZWRfZXhlYyh2b2lkKTsKIApkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tl
cm5lbC9mb3JrLmMKaW5kZXggNjUxMTNhMzA0NTE4Li4zODVkODA0MzJhODkgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpAQCAtNTI2LDcgKzUyNiw3IEBAIHZv
aWQgcHV0X3Rhc2tfc3RhY2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB9CiAjZW5kaWYKIAot
dm9pZCBmcmVlX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCitzdGF0aWMgdm9pZCBmcmVl
X3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB7CiAjaWZkZWYgQ09ORklHX1NFQ0NPTVAK
IAlXQVJOX09OX09OQ0UodHNrLT5zZWNjb21wLmZpbHRlcik7CkBAIC01NTUsNyArNTU1LDYgQEAg
dm9pZCBmcmVlX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiAJYnBmX3Rhc2tfc3RvcmFn
ZV9mcmVlKHRzayk7CiAJZnJlZV90YXNrX3N0cnVjdCh0c2spOwogfQotRVhQT1JUX1NZTUJPTChm
cmVlX3Rhc2spOwogCiB2b2lkIGR1cF9tbV9leGVfZmlsZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
c3RydWN0IG1tX3N0cnVjdCAqb2xkbW0pCiB7Cg==
--0000000000000491e3064c9abac4--

