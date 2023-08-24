Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D778713C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbjHXONg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbjHXONd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 10:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178B1BC8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692886366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YeFf3Wlrfc0CcBF8o0TQp1/prpVwhPD/RteH85vGLQ=;
        b=AkiXbAZxqxXnscVUi72xAF5tYTIFlSYiltqCJF8X3XUsTWkuyJrnc/rIyYw+W1tZ6cr6NQ
        I+BWTP/a0akuEEC1JP6haEmRk/WZ0gXhMKiQInG2wgrpJPXVpqexQ3U3XCR2A7k5jjyXhN
        C25xQIxDeQZbgpc7SY9e1pGomTJqVDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-_hajzuusPoSaJFW35qtFew-1; Thu, 24 Aug 2023 10:12:41 -0400
X-MC-Unique: _hajzuusPoSaJFW35qtFew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2988F823F65;
        Thu, 24 Aug 2023 14:12:37 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-2.rdu2.redhat.com [10.22.0.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85C8A140E963;
        Thu, 24 Aug 2023 14:12:35 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [NFSD]  39d432fc76:  fsmark.files_per_sec -100.0%
 regression
Date:   Thu, 24 Aug 2023 10:12:33 -0400
Message-ID: <D38094B9-CE6F-4BE1-9250-22073A1DD86E@redhat.com>
In-Reply-To: <ZOdZ7DiQ4jqhoj0i@tissot.1015granger.net>
References: <202308241229.68396422-oliver.sang@intel.com>
 <ZOdZ7DiQ4jqhoj0i@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Aug 2023, at 9:23, Chuck Lever wrote:

> On Thu, Aug 24, 2023 at 01:59:06PM +0800, kernel test robot wrote:
>>
>>
>> hi, Chuck Lever,
>>
>> Fengwei (CCed) helped us review this astonishing finding by fsmark tests,
>> and doubt below part:
>> -			nfsd4_end_grace(nn);
>> +			trace_nfsd_end_grace(netns(file));
>>
>> and confirmed if adding back:
>> 			nfsd4_end_grace(nn);
>>
>> the regression is gone and files_per_sec restore to 61.93.
>
> As always, thanks for the report. However, this result is not
> plausible. "end_grace" happens only once after a server reboot.
>
> Can you confirm that the NFS server kernel is not crashing
> during the test?

Does the removal of nfsd4_end_grace() here disable the ability of nfsdcltrack to
terminate the grace period early on a first start of the server?

Ben

