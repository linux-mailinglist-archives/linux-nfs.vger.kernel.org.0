Return-Path: <linux-nfs+bounces-8576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F79F3320
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF2C18839A2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A557205E1B;
	Mon, 16 Dec 2024 14:25:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9349203D77;
	Mon, 16 Dec 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359138; cv=none; b=U+btYV3gkv7C1ZC+YvPZWKOJmMmoJEA+qNgW43mG/ArJAOHDsdQrEqFPVtXPAuitv4Hc3jSNtqgo2olXb/k9UyxyZ6lDEE3dPLAFI+toYXT3GwCF9tJCurstanRyGId1aDlvv2P+y5hgkFQN72qryDhVYxjwkwSJCEaGiYldqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359138; c=relaxed/simple;
	bh=vjeFg3j3Ah3VWfc2JwG6Zxn74cBQAnEREUrBdSSqayQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0IWjV2wM+/qtzY8O9HLc86Fbd7znSUiVOhONZyYdrhEdzdbwDGCaNjvhsH/g7L+4zxfFkWJltCGZCODtjQ+pYYSMVnKhwZv7WoIRlXLREf+6tf5NkEu0+5tcgvwOqDIEO9zkYgXN87FHRYlbIndGoQVe+Ol1fedp8LMfe7177U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBhzy616nz4f3jqP;
	Mon, 16 Dec 2024 22:25:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 420811A018D;
	Mon, 16 Dec 2024 22:25:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoZXOGBnSTcXEw--.14700S4;
	Mon, 16 Dec 2024 22:25:32 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	yi.zhang@huawei.com
Subject: [RFC PATCH 0/5] nfsd/sunrpc: cleanup resource with sync mode
Date: Mon, 16 Dec 2024 22:21:51 +0800
Message-Id: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoZXOGBnSTcXEw--.14700S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rWF18uFWxCFy8CryxuFg_yoW8AFWDpF
	ZayrZxK3ykJFW7tanxZa1UXa4Fqr9Yyw18Jr1Fqw4Syr1ruw18Gw40yF409ryqqryrG3yj
	gr1UtFn8u3WkAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7sR_4lk7UUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

After f8c989a0c89a ("nfsd: release svc_expkey/svc_export with
rcu_work"), svc_export_put/expkey_put will call path_put with async
mode. This can lead some unexpected failure:

mkdir /mnt/sda
mkfs.xfs -f /dev/sda
echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
exportfs -ra
service nfs-server start
mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
mount /dev/sda /mnt/sda
touch /mnt1/sda/file
exportfs -r
umount /mnt/sda # failed unexcepted

The touch above will finally call nfsd_cross_mnt, add refcount to mount,
and then add cache_head. Before this commit, exportfs -r will call
cache_flush to cleanup all cache_head, and path_put in
svc_export_put/expkey_put will be finished with sync mode. So, the
latter umount will always success. However, after this commit, path_put
will be called with async mode, the latter umount may failed, and if we
add some delay, umount will success too. Personally I think this bug and
should be fixed. We first revert before bugfix patch, and then fix the
original bug with a different way.

Yang Erkun (5):
  nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"
  SUNRPC: move cache_put out from cache_check
  nfsd: no need get cache ref when protected by rcu
  SUNRPC: no need get cache ref when protected by rcu
  nfsd: fix UAF when access ex_uuid or ex_stats

 fs/nfs/dns_resolve.c              |  4 +++-
 fs/nfsd/export.c                  | 34 ++++++++++---------------------
 fs/nfsd/export.h                  |  4 ++--
 fs/nfsd/nfs4idmap.c               |  2 ++
 net/sunrpc/auth_gss/svcauth_gss.c |  9 ++++++--
 net/sunrpc/cache.c                | 11 ++--------
 net/sunrpc/svcauth_unix.c         | 12 ++++++++++-
 7 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.39.2


