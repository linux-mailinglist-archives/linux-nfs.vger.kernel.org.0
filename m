Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582C5E6171
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiIVLmk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiIVLm0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 07:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72B9B857
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663846944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO3m3gq+kyp87uiC5uU+VJH9t/F/t52t09XYK0EQ/ZU=;
        b=hpXp3BTnHzxEd1mDy1tS/7OeTOg6iSEbEqFM57+MGZD6Q0ZKM31gOQjCg+p3JTD0v435z0
        CQ+/HAQKp0tlHjxbUGaMyaU89vjsXMiRttC5g1cdq8arj/hBuL+JqswqTt0OH5h2Q141Zj
        04vuMPmOHjA7+RhAexdmoCt87R4Faxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-0oZC9QuBMkGrAV74fX45gQ-1; Thu, 22 Sep 2022 07:42:21 -0400
X-MC-Unique: 0oZC9QuBMkGrAV74fX45gQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2AB7811E67;
        Thu, 22 Sep 2022 11:42:20 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F2CF40C6EC2;
        Thu, 22 Sep 2022 11:42:20 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Maxwell" <amaxwell@fedex.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: nfsv4 client idmapper issue
Date:   Thu, 22 Sep 2022 07:42:18 -0400
Message-ID: <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
In-Reply-To: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Sep 2022, at 14:13, Alan Maxwell wrote:

> I am reporting an issue, not a fault or bugreport.
> NFS client : Redhat 7 kernel: 3.10.0-1160.71.1.el7.x86_64.
> The issue lies with the feature that nfs client that: if an nfs server 
> rejects an unmapped uid or gid, then the client will automatically 
> switch back to using the idmapper.
>
> Our particular configuration of nfsv4 server and client are based on 
> using numeric uidNumber and gidNumber communication.  The nfs server 
> we are using , OneFS (Dell/EMC/Isilon) has a setting explicitly for 
> this use: "Do not send names".  We have this set and our testing 
> showed working 100% with our nfs client.  The main driver for us using 
> this feature is that our uid's are numeric.  That causes issues with 
> commands like chown and apparently NFS setattr.  Once we realized 
> that, we set the numeric setting and everything worked as planned.
> Our problem with the feature comes due to a  simple mistake made by an 
> Admin:
>  chgrp groupnotvalid file
> When the admin issued a chgrp, but that group does not exist in the 
> directory service for the NFS server, the NFS server rejected the 
> change.  Then the feature kicked in that "client will automatically 
> switch back to using the idmapper. " Which did make changes, the 
> /proc/self/mountstats showing the caps=0x7fff instead of 0xffff.
> The only solution to get the mount to work as originally configured is 
> to umount/mount the share.
> Bottom line: Our environment can not support idmapping.  Having the 
> feature to disable it and that disable be forceful and not something 
> the kernel can decide to re-enable.
> We would envision that if an invalid chown/chgrp were issued, to 
> simply return an error, report that the chown/chgrp were not applied 
> and simply leave the nfsmount as is.
>
> Alan Maxwell | Sr. System Programmer | Platinum Infrastructure|20 
> FedEx Pkwy 1st Fl Vert,Collierville, TN 38017

Seems like a server bug to me -- if you want to set a numeric group on a
file, the server doesn't need to "look up" the group to see if it 
exists, it
should just set the value on the underlying filesystem.

What the server is signaling by sending back NFS4ERR_BADOWNER is that it
actually /is/ doing id mapping.

Why doesn't OneFS just set the value when told "Do not send names"?

Ben

