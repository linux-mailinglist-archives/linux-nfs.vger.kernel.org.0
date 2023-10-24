Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB99C7D5C46
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjJXUTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 16:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343752AbjJXUTW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 16:19:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70CD7A;
        Tue, 24 Oct 2023 13:19:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63283C433C7;
        Tue, 24 Oct 2023 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698178760;
        bh=/jXqC7vbvPCmettO3DV3ntCzZ6lqFawlTkTOPw+dpkg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cNFVEaHU/JSGFWmYYSgGbEUwcbU6E57XzHmF6PqxxLbNxe6qOiw0skHlgT2FAmt4E
         pi7vTvmXtMoxa+QN5NsjIdLL7cod+koC+MMTHlEpmPJUMjUC2aCFbd6V/QPJYLMFs8
         HeGKpzhI7MJVwlt6Q6WqHDPcW/boyVT98qJk/U++wdAZeq1FkdpLsbC5n4rWR+02Sm
         4Zz7+vBjkN7QlHu9uefsCd9OegvQAC62mZ6Y5yTZ4a6WJMK/LSFJN+jV5JHIiYtpq6
         BfJsXaU5B0axY0tFkCUNbOVQ0CdE3cC5UHu6WxcIlleK2U9pGJasSUCR6GhHkowEoo
         o0g7zaVbON3Zw==
Message-ID: <62828738f237c3d972f71f8da150b3366eb3e1a0.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 24 Oct 2023 16:19:17 -0400
In-Reply-To: <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
References: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
         <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
         <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
         <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
         <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
         <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
         <ZTGncMVw19QVJzI6@dread.disaster.area>
         <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
         <ZTWfX3CqPy9yCddQ@dread.disaster.area>
         <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
         <ZTcBI2xaZz1GdMjX@dread.disaster.area>
         <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
         <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
         <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-10-24 at 09:40 -1000, Linus Torvalds wrote:
> On Tue, 24 Oct 2023 at 09:07, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > The new flag idea is a good one. The catch though is that there are no
> > readers of i_version in-kernel other than NFSD and IMA, so there would
> > be no in-kernel users of I_VERSION_QUERIED_STRICT.
>=20
> I actually see that as an absolute positive.
>=20
> I think we should *conceptually* do those two flags, but then realize
> that there are no users of the STRICT version, and just skip it.
>=20
> So practically speaking, we'd end up with just a weaker version of
> I_VERSION_QUERIED that is that "I don't care about atime" case.
>=20

To be clear, this is not kernel-wide behavior. Most filesystems already
don't bump their i_version on atime updates. XFS is the only one that
does. ext4 used to do that too, but we fixed that several months ago.
I did try to just fix XFS in the same way, but the patch was NAK'ed.

> I really can't find any use that would *want* to see i_version updates
> for any atime updates. Ever.
>=20
> We may have had historical user interfaces for i_version, but I can't
> find any currently.
>=20
> But to be very very clear: I've only done some random grepping, and I
> may have missed something. I'm not dismissing Dave's worries, and he
> may well be entirely correct.
>=20
> Somebody would need to do a much more careful check than my "I can't
> find anything".

Exactly. I'm not really an XFS guy, so I took those folks at their word
that this was behavior that they just can't trivially change.

None of the in-kernel callers that look at i_version want it to be
incremented on atime-onlt updates, however. So IIRC, the objection was
due to offline repair/analysis tools that depend this the value being
incremented in a specific way.
--=20
Jeff Layton <jlayton@kernel.org>
