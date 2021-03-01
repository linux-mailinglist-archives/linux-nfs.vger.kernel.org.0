Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94C23285AA
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhCAQ4g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 11:56:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235844AbhCAQxH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 11:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614617499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwALXAHijNm9bXtn7hXML2Sh8ksKiKw4pUQfoz/Yf6o=;
        b=enOMRIzOlwQHH/7sRkeAwR+rrFBVXE9xg4A4d6+Vz9gQcMfmFrqUCArt641s+knKg6UBw0
        /ETqywPTlJy9qEZqMYX++FmJbUFxXy9M9DCgPgpmxHgnu9R+DlcbE0mdJv1r82Oiqx2FNk
        YEk70oTtfef6sRbxOIEpeMSjs9X9hDo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-RVx9_X5PMSm-5LCOJYr8cQ-1; Mon, 01 Mar 2021 11:51:36 -0500
X-MC-Unique: RVx9_X5PMSm-5LCOJYr8cQ-1
Received: by mail-pg1-f200.google.com with SMTP id c30so10126172pgl.15
        for <linux-nfs@vger.kernel.org>; Mon, 01 Mar 2021 08:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwALXAHijNm9bXtn7hXML2Sh8ksKiKw4pUQfoz/Yf6o=;
        b=HJeTzSIqsYF6ESwvL5CmGfzcRSAeC0WaZTOKk6+IkMwyIasMKOPFwWp30IfVFF59v2
         Jpw4JNfxp7gdo2aCGPp56TnD5cePQXkQrnVqrzUppvr0OQw40DYIh4w66dCwNJXauB4X
         lBw2EpSQogdrQaFxBrflDwBSA/hHSqptR1ognqj9NcZ8DB1HEF5H8n6r/JpjHPrO+ieK
         afGDKcMMg9CWVnyZSmhMOQMjVb9CNF16lpcFaYneZW2WKjCYeCw2O0yfBiJ/i3bpFCk/
         bALZRiFDuXb6/EDaNPnjJ+cWHFd44x0wn4B9P+lWsCUs+1J3/qXmdjWtu3rFltT0Y4xE
         kP9g==
X-Gm-Message-State: AOAM533MufQFfpDqB+9ncga9N4kMlaIO5UCgeHAM4mvcXY/M41inodLJ
        IWQC1jNMvxf8eQJulXkeYpbKX6IycnWMeps00njJm3HGT9XgWbT6gJ1FvNVewCiU+u1K1ZBt8DU
        lPhrSS1SjrYbvg1sMjI3GR2FbsPjHZ9dxRuk9
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr15919510pff.34.1614617495387;
        Mon, 01 Mar 2021 08:51:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyku1AYSIPuJwUINda/epiFmTDpOYCDUov4BF7c8GivAu4/fr3DJRzKgnrRS8bR+3UlfxUHYlEs1rM5UEUonvo=
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id
 v11-20020aa7808b0000b02901ce8a32f5e8mr15919482pff.34.1614617494993; Mon, 01
 Mar 2021 08:51:34 -0800 (PST)
MIME-Version: 1.0
References: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
 <ff7d4adc-2d4a-d5cc-fa0a-1f808b571fad@RedHat.com> <CALe0_75aeott7xJn0FxSMSANx0AwsxLtjNLC6YZycuE7yN+mGA@mail.gmail.com>
In-Reply-To: <CALe0_75aeott7xJn0FxSMSANx0AwsxLtjNLC6YZycuE7yN+mGA@mail.gmail.com>
From:   Jacob Shivers <jshivers@redhat.com>
Date:   Mon, 1 Mar 2021 11:50:58 -0500
Message-ID: <CALe0_74mGBcaNZ_RFZJUzWhG6=4YiP9c9_qBn7RwK0RdjXoa_Q@mail.gmail.com>
Subject: Re: gssd: set $HOME to prevent recursion when home dirs are on
 kerberized NFS mount revisted
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003df26b05bc7c6e30"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--0000000000003df26b05bc7c6e30
Content-Type: text/plain; charset="UTF-8"

Patches that include a '-H' flag and man page entry.

The default is to maintain behavior since
2f682f25c642fcfe7c511d04bc9d67e732282348, but passing '-H' avoids
$HOME being set to '/'.
Also included a patch for /etc/nfs.conf to add 'set-home=1'. Setting
it to false is equivalent to passing '-H' to rpc.gssd.

Regards,

Jacob Shivers

On Mon, Jan 4, 2021 at 11:00 AM Jacob Shivers <jshivers@redhat.com> wrote:
>
> Hello,
>
> I completely missed this so please excuse the delay.
>
> > On 11/23/20 1:17 PM, Jacob Shivers wrote:
> > > Commit 2f682f25c642fcfe7c511d04bc9d67e732282348 changed existing
> > > behavior to avoid a deadlock for users using Kerberized NFS home dirs.
> > >
> > > However, this also prevents users leveraging their own k5identity
> > > files under their home directory and instead rpc.gssd uses a
> > > system-wide /.k5identity file. For users expecting to use their own
> > > k5identity file this is certainly unexpected.
> > So how is the deadlock not happening when ~/.k5identity is on a NFS
> > home directory? What am I missing?
> They are not using NFS for home directories. They are accessing
> systems with a local fs backing the /home
>
> > > Below is some pseudo code that was proposed and would just add a flag
> > > allowing for the behavior prior to
> > > 2f682f25c642fcfe7c511d04bc9d67e732282348:
> > >
> > > /* psudo code snippet starts here */
> > >         /*
> > >          * Some krb5 routines try to scrape info out of files in the user's
> > >          * home directory. This can easily deadlock when that homedir is on a
> > > -        * kerberized NFS mount. By setting $HOME unconditionally to "/", we
> > > +        * kerberized NFS mount. Some users may not have $HOME on NFS.
> > > +        * By default setting $HOME unconditionally to "/", we
> > >          * prevent this behavior in routines that use $HOME in preference to
> > >          * the results of getpw*.
> > > +        * Users who have $HOME on krb5-NFS should set
> > > `--home-not-kerberized` in argv
> > > +        * Users who have $HOME on krb5-NFS but want to use their
> > > $HOME anyway should set NFS_HOME_ACCESSIBLE=TRUE
> > >          */
> > > +       if (argv == '--home-not-kerberized') ||
> > > (getenv("NFS_HOME_ACCESSIBLE") == 'TRUE') {
> > > +               log.debug('Not masking $HOME, this breaks on Kerberized $HOME');
> > > +       }
> > > +       else {
> > > +               log.debug('Assuming $HOME requires Kerberos, use
> > > `--home-not-kerberized` to change this behavior');
> > >         if (setenv("HOME", "/", 1)) {
> > >                 printerr(1, "Unable to set $HOME: %s\n", strerror(errn));
> > >                 exit(1);
> > >         }
> > > +       }
> > > /* psudo code snippet ends here */
> > In general I'm pretty reluctant to add flags but what is needed
> > to do so is a company single letter flag '-H' and a man page
> > entry describing the flag.
> Ok.
>
> > >
> > > While acknowledging the use of this flag for Kerberized NFS home dirs
> > > is undesirable and would cause a deadlock, there should be no issue
> > > for users not using Kerberized NFS home dirs.
> > What apps are you using that is seeing this problem?
> It is just when accessing the Kerberized NFS share. Other Kerberos
> aware services/applications check for the existence of ~/.k5identify
> before reading /var/kerberos/krb5/user/${EUID}/client.keytab. rpc.gssd
> no longer does this and the intent of the patch would be to add
> granularity to choose the behavior or rpc.gssd with respect to
> scanning for a k5identity file.
>
> If any additional information is required, please inform me.
>
> Thanks,
>
> Jacob Shivers

--0000000000003df26b05bc7c6e30
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-nfsconf_set-home.patch"
Content-Disposition: attachment; filename="0001-nfsconf_set-home.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klqtj9ao1>
X-Attachment-Id: f_klqtj9ao1

ZGlmZiAtLWdpdCBhL25mcy5jb25mIGIvbmZzLmNvbmYKaW5kZXggOWZjZjFiZi4uNGM0MTY2NiAx
MDA2NDQKLS0tIGEvbmZzLmNvbmYKKysrIGIvbmZzLmNvbmYKQEAgLTI0LDYgKzI0LDcgQEAKICMg
a2V5dGFiLWZpbGU9L2V0Yy9rcmI1LmtleXRhYgogIyBjcmVkLWNhY2hlLWRpcmVjdG9yeT0KICMg
cHJlZmVycmVkLXJlYWxtPQorIyBzZXQtaG9tZT0xCiAjCiBbbG9ja2RdCiAjIHBvcnQ9MAo=
--0000000000003df26b05bc7c6e30
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-gssd-set_home.patch"
Content-Disposition: attachment; filename="0001-gssd-set_home.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klqtj98k0>
X-Attachment-Id: f_klqtj98k0

ZGlmZiAtLWdpdCBhL3V0aWxzL2dzc2QvZ3NzZC5jIGIvdXRpbHMvZ3NzZC9nc3NkLmMKaW5kZXgg
ODViYzRiMDcuLjE1NDFkMzcxIDEwMDY0NAotLS0gYS91dGlscy9nc3NkL2dzc2QuYworKysgYi91
dGlscy9nc3NkL2dzc2QuYwpAQCAtODcsNiArODcsOCBAQCB1bnNpZ25lZCBpbnQgIGNvbnRleHRf
dGltZW91dCA9IDA7CiB1bnNpZ25lZCBpbnQgIHJwY190aW1lb3V0ID0gNTsKIGNoYXIgKnByZWZl
cnJlZF9yZWFsbSA9IE5VTEw7CiBjaGFyICpjY2FjaGVkaXIgPSBOVUxMOworLyogc2V0ICRIT01F
IHRvICIvIiBieSBkZWZhdWx0ICovCitzdGF0aWMgYm9vbCBzZXRfaG9tZSA9IHRydWU7CiAvKiBB
dm9pZCBETlMgcmV2ZXJzZSBsb29rdXBzIG9uIHNlcnZlciBuYW1lcyAqLwogc3RhdGljIGJvb2wg
YXZvaWRfZG5zID0gdHJ1ZTsKIHN0YXRpYyBib29sIHVzZV9nc3Nwcm94eSA9IGZhbHNlOwpAQCAt
OTAwLDcgKzkwMiw3IEBAIHNpZ19kaWUoaW50IHNpZ25hbCkKIHN0YXRpYyB2b2lkCiB1c2FnZShj
aGFyICpwcm9nbmFtZSkKIHsKLQlmcHJpbnRmKHN0ZGVyciwgInVzYWdlOiAlcyBbLWZdIFstbF0g
Wy1NXSBbLW5dIFstdl0gWy1yXSBbLXAgcGlwZWZzZGlyXSBbLWsga2V5dGFiXSBbLWQgY2NhY2hl
ZGlyXSBbLXQgdGltZW91dF0gWy1SIHByZWZlcnJlZCByZWFsbV0gWy1EXVxuIiwKKwlmcHJpbnRm
KHN0ZGVyciwgInVzYWdlOiAlcyBbLWZdIFstbF0gWy1NXSBbLW5dIFstdl0gWy1yXSBbLXAgcGlw
ZWZzZGlyXSBbLWsga2V5dGFiXSBbLWQgY2NhY2hlZGlyXSBbLXQgdGltZW91dF0gWy1SIHByZWZl
cnJlZCByZWFsbV0gWy1EXSBbLUhdXG4iLAogCQlwcm9nbmFtZSk7CiAJZXhpdCgxKTsKIH0KQEAg
LTk0MSw2ICs5NDMsNyBAQCByZWFkX2dzc19jb25mKHZvaWQpCiAJCXByZWZlcnJlZF9yZWFsbSA9
IHM7CiAKIAl1c2VfZ3NzcHJveHkgPSBjb25mX2dldF9ib29sKCJnc3NkIiwgInVzZS1nc3MtcHJv
eHkiLCB1c2VfZ3NzcHJveHkpOworCXNldF9ob21lID0gY29uZl9nZXRfYm9vbCgiZ3NzZCIsICJz
ZXQtaG9tZSIsIHNldF9ob21lKTsKIH0KIAogaW50CkBAIC05NjEsNyArOTY0LDcgQEAgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQogCXZlcmJvc2l0eSA9IGNvbmZfZ2V0X251bSgiZ3NzZCIs
ICJ2ZXJib3NpdHkiLCB2ZXJib3NpdHkpOwogCXJwY192ZXJib3NpdHkgPSBjb25mX2dldF9udW0o
Imdzc2QiLCAicnBjLXZlcmJvc2l0eSIsIHJwY192ZXJib3NpdHkpOwogCi0Jd2hpbGUgKChvcHQg
PSBnZXRvcHQoYXJnYywgYXJndiwgIkRmdnJsbW5NcDprOmQ6dDpUOlI6IikpICE9IC0xKSB7CisJ
d2hpbGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJndiwgIkhEZnZybG1uTXA6azpkOnQ6VDpSOiIp
KSAhPSAtMSkgewogCQlzd2l0Y2ggKG9wdCkgewogCQkJY2FzZSAnZic6CiAJCQkJZmcgPSAxOwpA
QCAtMTAwOSw2ICsxMDEyLDkgQEAgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQkJY2Fz
ZSAnRCc6CiAJCQkJYXZvaWRfZG5zID0gZmFsc2U7CiAJCQkJYnJlYWs7CisJCQljYXNlICdIJzoK
KwkJCQlzZXRfaG9tZSA9IGZhbHNlOworCQkJCWJyZWFrOwogCQkJZGVmYXVsdDoKIAkJCQl1c2Fn
ZShhcmd2WzBdKTsKIAkJCQlicmVhazsKQEAgLTEwMTgsMTMgKzEwMjQsMTkgQEAgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQogCS8qCiAJICogU29tZSBrcmI1IHJvdXRpbmVzIHRyeSB0byBz
Y3JhcGUgaW5mbyBvdXQgb2YgZmlsZXMgaW4gdGhlIHVzZXIncwogCSAqIGhvbWUgZGlyZWN0b3J5
LiBUaGlzIGNhbiBlYXNpbHkgZGVhZGxvY2sgd2hlbiB0aGF0IGhvbWVkaXIgaXMgb24gYQotCSAq
IGtlcmJlcml6ZWQgTkZTIG1vdW50LiBCeSBzZXR0aW5nICRIT01FIHVuY29uZGl0aW9uYWxseSB0
byAiLyIsIHdlCi0JICogcHJldmVudCB0aGlzIGJlaGF2aW9yIGluIHJvdXRpbmVzIHRoYXQgdXNl
ICRIT01FIGluIHByZWZlcmVuY2UgdG8KLQkgKiB0aGUgcmVzdWx0cyBvZiBnZXRwdyouCisJICog
a2VyYmVyaXplZCBORlMgbW91bnQuIEJ5IHNldHRpbmcgJEhPTUUgdG8gIi8iIGJ5IGRlZmF1bHQs
IHdlIHByZXZlbnQKKwkgKiB0aGlzIGJlaGF2aW9yIGluIHJvdXRpbmVzIHRoYXQgdXNlICRIT01F
IGluIHByZWZlcmVuY2UgdG8gdGhlIHJlc3VsdHMKKwkgKiBvZiBnZXRwdyouCisJICoKKwkgKiBT
b21lIHVzZXJzIGRvIG5vdCB1c2UgS2VyYmVyaXplZCBob21lIGRpcnMgYW5kIG5lZWQgJEhPTUUg
dG8gcmVtYWluCisJICogdW5jaGFuZ2VkLiBUaG9zZSB1c2VycyBjYW4gbGVhdmUgJEhPTUUgdW5j
aGFuZ2VkIGJ5IHNldHRpbmcgc2V0X2hvbWUKKwkgKiB0byBmYWxzZS4KIAkgKi8KLQlpZiAoc2V0
ZW52KCJIT01FIiwgIi8iLCAxKSkgewotCQlwcmludGVycigwLCAiZ3NzZDogVW5hYmxlIHRvIHNl
dCAkSE9NRTogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7Ci0JCWV4aXQoMSk7CisJaWYgKHNldF9o
b21lKSB7CisJCWlmIChzZXRlbnYoIkhPTUUiLCAiLyIsIDEpKSB7CisJCQlwcmludGVycigwLCAi
Z3NzZDogVW5hYmxlIHRvIHNldCAkSE9NRTogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CisJCQll
eGl0KDEpOworCQl9CiAJfQogCiAJaWYgKHVzZV9nc3Nwcm94eSkgewo=
--0000000000003df26b05bc7c6e30
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-manpage-nfs.conf_update_for_set-home.patch"
Content-Disposition: attachment; 
	filename="0001-manpage-nfs.conf_update_for_set-home.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klqtj9av3>
X-Attachment-Id: f_klqtj9av3

ZGlmZiAtLWdpdCBhL3N5c3RlbWQvbmZzLmNvbmYubWFuIGIvc3lzdGVtZC9uZnMuY29uZi5tYW4K
aW5kZXggMTZlMGVjNC4uZWU1NDA0MSAxMDA2NDQKLS0tIGEvc3lzdGVtZC9uZnMuY29uZi5tYW4K
KysrIGIvc3lzdGVtZC9uZnMuY29uZi5tYW4KQEAgLTI0Myw3ICsyNDMsOCBAQCBSZWNvZ25pemVk
IHZhbHVlczoKIC5CUiBycGMtdGltZW91dCAsCiAuQlIga2V5dGFiLWZpbGUgLAogLkJSIGNyZWQt
Y2FjaGUtZGlyZWN0b3J5ICwKLS5CUiBwcmVmZXJyZWQtcmVhbG0gLgorLkJSIHByZWZlcnJlZC1y
ZWFsbSAsCisuQlIgc2V0LWhvbWUgLgogCiBTZWUKIC5CUiBycGMuZ3NzZCAoOCkK
--0000000000003df26b05bc7c6e30
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-manpage-rpc.gssd_update_for_set-home.patch"
Content-Disposition: attachment; 
	filename="0001-manpage-rpc.gssd_update_for_set-home.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klqtj9aq2>
X-Attachment-Id: f_klqtj9aq2

ZGlmZiAtLWdpdCBhL3V0aWxzL2dzc2QvZ3NzZC5tYW4gYi91dGlscy9nc3NkL2dzc2QubWFuCmlu
ZGV4IDI2MDk1YTguLmI2NDQ0YWIgMTAwNjQ0Ci0tLSBhL3V0aWxzL2dzc2QvZ3NzZC5tYW4KKysr
IGIvdXRpbHMvZ3NzZC9nc3NkLm1hbgpAQCAtOCw3ICs4LDcgQEAKIHJwYy5nc3NkIFwtIFJQQ1NF
Q19HU1MgZGFlbW9uCiAuU0ggU1lOT1BTSVMKIC5CIHJwYy5nc3NkCi0uUkIgWyBcLURmTW5sdnIg
XQorLlJCIFsgXC1EZk1ubHZySCBdCiAuUkIgWyBcLWsKIC5JUiBrZXl0YWIgXQogLlJCIFsgXC1w
CkBAIC0yODIsNiArMjgyLDE2IEBAIFRoZSBkZWZhdWx0IHRpbWVvdXQgaXMgc2V0IHRvIDUgc2Vj
b25kcy4KIElmIHlvdSBnZXQgbWVzc2FnZXMgbGlrZSAiV0FSTklORzogY2FuJ3QgY3JlYXRlIHRj
cCBycGNfY2xudCB0byBzZXJ2ZXIKICVzZXJ2ZXJuYW1lJSBmb3IgdXNlciB3aXRoIHVpZCAldWlk
JTogUlBDOiBSZW1vdGUgc3lzdGVtIGVycm9yIC0KIENvbm5lY3Rpb24gdGltZWQgb3V0IiwgeW91
IHNob3VsZCBjb25zaWRlciBhbiBpbmNyZWFzZSBvZiB0aGlzIHRpbWVvdXQuCisuVFAKKy5CIC1I
CitBdm9pZHMgc2V0dGluZyAkSE9NRSB0byAiLyIuIFRoaXMgYWxsb3dzIHJwYy5nc3NkIHRvIHJl
YWQgcGVyIHVzZXIgazVpZGVudGl0eQorZmlsZXMgdmVyc3VzIHRyeWluZyB0byByZWFkIC8uazVp
ZGVudGl0eSBmb3IgZWFjaCB1c2VyLgorCitJZgorLkIgXC1ICitpcyBub3Qgc2V0LCBycGMuZ3Nz
ZCB3aWxsIHVzZSB0aGUgZmlyc3QgbWF0Y2ggZm91bmQgaW4KKy92YXIva2VyYmVyb3Mva3JiNS91
c2VyLyRFVUlEL2NsaWVudC5rZXl0YWIgYW5kIHdpbGwgbm90IHVzZSBhIHByaW5jaXBhbCBiYXNl
ZCBvbgoraG9zdCBhbmQvb3Igc2VydmljZSBwYXJhbWV0ZXJzIGxpc3RlZCBpbiAkSE9NRS8uazVp
ZGVudGl0eS4KIC5TSCBDT05GSUdVUkFUSU9OIEZJTEUKIE1hbnkgb2YgdGhlIG9wdGlvbnMgdGhh
dCBjYW4gYmUgc2V0IG9uIHRoZSBjb21tYW5kIGxpbmUgY2FuIGFsc28gYmUKIGNvbnRyb2xsZWQg
dGhyb3VnaCB2YWx1ZXMgc2V0IGluIHRoZQpAQCAtMzQ3LDYgKzM1NywxMyBAQCBzZWN0aW9uOgog
LkIgcGlwZWZzLWRpcmVjdG9yeQogRXF1aXZhbGVudCB0bwogLkJSIC1wIC4KKy5UUAorLkIgc2V0
LWhvbWUKK1NldHRpbmcgdG8KKy5CIGZhbHNlCitpcyBlcXVpdmFsZW50IHRvIHByb3ZpZGluZyB0
aGUKKy5CIC1ICitmbGFnLgogCiAuU0ggU0VFIEFMU08KIC5CUiBycGMuc3ZjZ3NzZCAoOCksCg==
--0000000000003df26b05bc7c6e30--

