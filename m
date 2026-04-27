Return-Path: <linux-nfs+bounces-21176-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDyDOQ9l72kIBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21176-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:30:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D625B4736F1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E244F3006B5B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE793CB2E7;
	Mon, 27 Apr 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dftlO/sj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C73C6608;
	Mon, 27 Apr 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296650; cv=none; b=Je2QXGnl89dNKBBEcpzkD/LVOTeZovPiwIm6ZEoy8IPaN7u1iWwGNcr9MFalCtbpe2KJ4yry7qYTFi3NuoSAbBtiPYIs1XERflrESmpq0fVwJ7JTZzJsTC1CR65L5jjEOtmF82aHO/Jj5UY6pFKjMZKQQnDW/x4qvy2GIySRoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296650; c=relaxed/simple;
	bh=03W80pIWVWG5o5UNqlq/tIYlCj2935WYMgLISQY0J+8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N6eDpWJJulN9+EDqMmahanGMixPJx4rkkszwDgYS0kNInGzq0MXOuabzAMRkCdSWE0cq5RDH+PnW14LBjEzn7u3L/VMEJ5DFnfAazLqgo4hrufHVAVhDFvo0q4oeHJRSGPsZ9+IR/Lk8HcUaa9X0eiu3L2IAZ/BrYAwImkWLOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dftlO/sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD4FC19425;
	Mon, 27 Apr 2026 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296650;
	bh=03W80pIWVWG5o5UNqlq/tIYlCj2935WYMgLISQY0J+8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dftlO/sjUHBB53HxpiOwjQgvxQcH8Rgr8BHjy7bklMjOKGP7VMwxXvGjvnK1gKH+A
	 LCk7hHw8jf4QO2+QOlmPqEeShr/kz0sS6XQMYA6CJWOMBgesi237U/30L5SeFDcNI5
	 oWB3cDtyaPSn3SJoAnA6ZdIw9aiXO9mmsQiPpa0yKEtm/b14BqT57tbJp+bq46drAL
	 HW+G7p92gxsC3dBsKspT5giWs0SQiYJah+3K+5iDI+CEvpbAhQj3PAsE9rNxFLjpqu
	 9TzkhGWVW8Y/0CK67qqsocBgivvhr+ZzMehuGclPVpISyplfqwiYMdhJ3qVaMf79ow
	 hXfbIlCBlJqJQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EBB8F40084;
	Mon, 27 Apr 2026 09:30:48 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 27 Apr 2026 09:30:48 -0400
X-ME-Sender: <xms:CGXvadxt2wdw8um2C_FldexfTHG2a_BWlEE_4pL26QlgkVGgm4NRMA>
    <xme:CGXvaYFCgGeuXImAgatV2cE6NaxoQVjNdbYwyNeC-YTWY-ekLAbECqhdDMD_DoiMW
    k9m6sM-kYg4B-PgwN3zVDTCj_E27-H6xIVwsOv_OueAFQGZerzcY7Cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptdeljeehtefhleeghfejgfetieethedugfeiveffgeekjeekvedvleeigedvueejnecu
    ffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peefhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgvnhhoiihhrghtshhkhi
    estghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprgguihhlghgvrhdrkhgvrhhnvghl
    seguihhlghgvrhdrtggrpdhrtghpthhtohepshhlrghvrgesughusggvhihkohdrtghomh
    dprhgtphhtthhopehrohhnnhhivghsrghhlhgsvghrghesghhmrghilhdrtghomhdprhgt
    phhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CGXvaX8tBzgQztb9zSDQ76htesdgV6Vy50k_XUzdXlbMrKViYGRcLA>
    <xmx:CGXvafGXQX9GnYmK00efpJNIia8RGnt5no7ofoofBc6aBUMO76caGA>
    <xmx:CGXvaeY9TVr2qcEQtevQDZAOM3PhZ60kvZ80aZyDv7XZa90PsBnYrQ>
    <xmx:CGXvabNG889hC2q-Vkkt-bdWC3vUWvYgKi3-o-BGPCmTHb-y9t0Ysg>
    <xmx:CGXvaXzXxohsjC-OhEuqud4KdFLo8XT-e-9JXsvOgnCcjmbNJS4e-DFk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D33F780070; Mon, 27 Apr 2026 09:30:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASNSHzdsFZdw
Date: Mon, 27 Apr 2026 09:30:28 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jan Kara" <jack@suse.cz>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 almaz.alexandrovich@paragon-software.com,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 frank.li@vivo.com, "Theodore Tso" <tytso@mit.edu>,
 adilger.kernel@dilger.ca, "Carlos Maiolino" <cem@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Hans de Goede" <hansg@kernel.org>,
 senozhatsky@chromium.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Roland Mainz" <roland.mainz@nrubsig.org>,
 "Steve French" <stfrench@microsoft.com>
Message-Id: <af3f7518-7501-4c25-9bbc-a8fc8cdb4e29@app.fastmail.com>
In-Reply-To: 
 <yc7ygk6w6zvf46arzzvmxnuoqjrni2dtlhmywaivzmvfxnilf3@xv7tthtrowns>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <yc7ygk6w6zvf46arzzvmxnuoqjrni2dtlhmywaivzmvfxnilf3@xv7tthtrowns>
Subject: Re: [PATCH v11 00/15] Exposing case folding behavior
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D625B4736F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21176-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, Apr 27, 2026, at 6:55 AM, Jan Kara wrote:
> On Fri 24-04-26 21:53:02, Chuck Lever wrote:
>> Changes since v10:
>> - cifs: Source case-handling flags from the server's cached
>>   FS_ATTRIBUTE_INFORMATION reply instead of the nocase mount
>>   option, with a nocase fallback when the reply is absent
>> - Address findings from sashiko(gemini-3) and gpt-5.5:
>>   - nfs: Skip pathconf case bits on NFSv4 (set via FATTR4_CASE_*
>>     instead)
>>   - xfs: Hide FS_CASEFOLD_FL from the legacy flags view so
>>     chattr round-trips do not hit the setflags whitelist
>>   - ext4, f2fs: Drop redundant fileattr_get patches; the
>>     FS_CASEFOLD_FL translation in fileattr_fill_flags() already
>>     reports FS_XFLAG_CASEFOLD for casefolded directories
>
> Err, how is this supposed to work? I wasn't able to find any code
> transforming S_CASEFOLDED inode flag into FS_CASEFOLD_FL on fileattr_get
> path. Sure, fileattr_fill_flags() takes care of setting FS_XFLAG_CASEFOLD
> once FS_CASEFOLD_FL is set. What am I missing?

Agreed, that is a little surprising.

The path does not go through S_CASEFOLD.  Both filesystems
report FS_CASEFOLD_FL straight from their on-disk flag word.

For ext4, EXT4_CASEFOLD_FL is 0x40000000, the same bit value
as FS_CASEFOLD_FL, and it is included in EXT4_FL_USER_VISIBLE.
ext4_iget() loads it into ei->i_flags directly from
raw_inode->i_flags (fs/ext4/inode.c:5358). ext4_fileattr_get()
then masks with EXT4_FL_USER_VISIBLE and hands the result to
fileattr_fill_flags(), which translates FS_CASEFOLD_FL into
FS_XFLAG_CASEFOLD on the way out.

For f2fs, f2fs_fileattr_get() runs fi->i_flags through
f2fs_iflags_to_fsflags(), whose mapping table has an explicit
{ F2FS_CASEFOLD_FL, FS_CASEFOLD_FL } entry (fs/f2fs/file.c:2205).
F2FS_GETTABLE_FS_FL includes FS_CASEFOLD_FL, so
fileattr_fill_flags() again lights up FS_XFLAG_CASEFOLD.

S_CASEFOLD is a separate VFS-level cache that
ext4_set_inode_flags() and f2fs's equivalent set at iget
time; nothing on the fileattr_get path consults it.

For reference, the original observation about the manual
assignment being redundant came from sashiko's review of v10:

  https://sashiko.dev/#/patchset/20260423-case-sensitivity-v10-0-c385d674a6cf%40oracle.com?part=8                                             
  https://sashiko.dev/#/patchset/20260423-case-sensitivity-v10-0-c385d674a6cf%40oracle.com?part=12  


-- 
Chuck Lever

